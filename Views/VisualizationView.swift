//
//  SwiftUIView.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 02/08/25.
//

import SwiftUI

struct VisualizationView: View {
    @StateObject var viewModel: AlgoVisualizerViewModel
    
    var body: some View {
        VStack {
            // Main array view
            GeometryReader { geometry in
                if !viewModel.arrayData.isEmpty {
                    let elementSize = calculateElementSize(
                        count: viewModel.arrayData.count,
                        availableWidth: geometry.size.width
                    )
                    HStack {
                        Spacer()
                        ArrayView(array: viewModel.arrayData, size: elementSize)
                        Spacer()
                    }
                }
            }
            .frame(minHeight: 75, maxHeight: 100)

            // Prefix sum result view
            if !viewModel.prefixSumData.isEmpty {
                VStack {
                    Text("Prefix Sum Array:").font(.headline)
                    GeometryReader { geometry in
                        let elementSize = calculateElementSize(
                            count: viewModel.prefixSumData.count,
                            availableWidth: geometry.size.width
                        )
                        HStack {
                            Spacer()
                            ArrayView(array: viewModel.prefixSumData, size: elementSize)
                            Spacer()
                        }
                    }
                }
                .frame(height: 75)
                .transition(.opacity.combined(with: .scale))
            }
        }
        .padding(.bottom, 32)
    }
    
    private func calculateElementSize(count: Int, availableWidth: CGFloat)
        -> CGFloat
    {
        let maxElementWidth: CGFloat = 60
        let spacing: CGFloat = 10

        // Formula to calculate width based on available space
        let calculatedWidth =
            (availableWidth - (CGFloat(count) * spacing)) / CGFloat(count)

        // We don't want elements to be huge if there are only a few.
        // So we return the smaller of our calculation and the max size.
        return min(calculatedWidth, maxElementWidth)
    }  //helper function to calculate array element size (for presenting dynamic UI)
}
