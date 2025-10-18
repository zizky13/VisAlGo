//
//  SwiftUIView.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 02/08/25.
//

import SwiftUI

struct AlgorithmControlsView: View {
    @StateObject var viewModel: AlgoVisualizerViewModel
    let proxy: ScrollViewProxy
    @FocusState.Binding var focusedField: FormFocus?
    
    var body: some View {
            VStack {
                Text("2. Choose Algorithm & Run")
                    .font(.headline)

                Picker("Algorithm", selection: $viewModel.selectedAlgorithm) {
                    ForEach(Algorithm.allCases) { Text($0.rawValue).tag($0) }
                }
                .pickerStyle(.segmented)
                .pickerStyle(.segmented)
                .onChange(of: viewModel.selectedAlgorithm) { _ in
                    // Clear prefix sum array if we switch away from it
                    if viewModel.selectedAlgorithm != .prefixSum {
                        viewModel.prefixSumData = []
                    }
                }

                // This view is in the Array tab, so it passes the selected array algorithm.
                AlgorithmInfoView(algorithm: viewModel.selectedAlgorithm) {
                    viewModel.loadSample(for: viewModel.selectedAlgorithm)
                }

                // --- CONDITIONAL PARAMETER FIELDS ---
                if viewModel.selectedAlgorithm == .twoPointers {
                    // -- SHOWS OPTIONS SPECIFIC TO TWO POINTERS
                    HStack {
                        TextField("Left Index", text: $viewModel.leftPointerInput)
                            .textFieldStyle(.roundedBorder).keyboardType(.numberPad)
                            .focused($focusedField, equals: .leftPointer)
                        TextField("Right Index", text: $viewModel.rightPointerInput)
                            .textFieldStyle(.roundedBorder).keyboardType(.numberPad)
                            .focused($focusedField, equals: .rightPointer)
                    }
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }

                if viewModel.selectedAlgorithm == .slidingWindow {
                    // -- SHOWS OPTIONS SPECIFIC TO SLIDING WINDOW
                    TextField("Window Size", text: $viewModel.windowSizeInput).textFieldStyle(
                        .roundedBorder
                    ).keyboardType(.numberPad).focused(
                        $focusedField,
                        equals: .windowSize
                    )
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }

                // --- UNIFIED RUN BUTTON ---
                Button("Run Algorithm") {
                    focusedField = nil
                    withAnimation {
                        proxy.scrollTo("arrayVisualization", anchor: .center)
                    }
                    viewModel.runSelectedAlgorithm()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .animation(.default, value: viewModel.selectedAlgorithm)
        }
}
