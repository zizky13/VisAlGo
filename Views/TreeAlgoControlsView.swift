//
//  File.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 03/08/25.
//

import SwiftUI


struct TreeAlgoControlsView: View {
    @ObservedObject var viewModel: AlgoVisualizerViewModel
    let proxy: ScrollViewProxy
    
    var body: some View {
        VStack(spacing: 15) {
            Picker("Algorithm", selection: $viewModel.selectedTreeAlgorithm) {
                ForEach(TreeAlgorithm.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            
            AlgorithmInfoView(algorithm: viewModel.selectedTreeAlgorithm) {
                viewModel.loadSample(for: viewModel.selectedTreeAlgorithm)
            }
            
            Button("Run Algorithm") {
                withAnimation {
                    proxy.scrollTo("treeVisualization", anchor: .center)
                }
                
                viewModel.runSelectedTreeAlgorithm()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        
    }
}
