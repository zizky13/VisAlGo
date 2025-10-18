//
//  SwiftUIView.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 02/08/25.
//

import SwiftUI

struct ArraySetupView: View {
    //-- PARAMS FOR THIS VIEW --
    @ObservedObject var viewModel: AlgoVisualizerViewModel
    @FocusState.Binding var focusedField: FormFocus?
    
    var body: some View {
        VStack {
            Picker("Data Type", selection: $viewModel.selectedType){
                ForEach(DataType.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            //-- IF ANY CHANGE IS MADE TO THE SELECTED TYPE, RUN setupArray()
            .onChange(of: viewModel.selectedType) { _ in viewModel.setupArray() }

            TextField(
                "Enter array values (e.g., 5,1,8 or hello)",
                text: $viewModel.arrayInput
            )
            .textFieldStyle(.roundedBorder)
            .focused($focusedField, equals: .arrayInput)

            Button("Setup Array") {
                focusedField = nil
                viewModel.setupArray()
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)

    }
}
