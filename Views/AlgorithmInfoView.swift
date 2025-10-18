//
//  SwiftUIView.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 01/08/25.
//

import SwiftUI

struct AlgorithmInfoView: View {
    let algorithm: DescribableAlgorithm
    // This is a callback function to tell ContentView to load the sample
    var onLoadSample: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(algorithm.description)
                .font(.body)

            Text(algorithm.useCase)
                .font(.footnote)
                .foregroundColor(.secondary)

            Button(action: onLoadSample) {
                Label("Load Sample Case", systemImage: "sparkles")
            }
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
