//
//  File.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 03/08/25.
//

import SwiftUI

struct TreeSetupView: View {
    @ObservedObject var viewModel: AlgoVisualizerViewModel
    @FocusState.Binding var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            TextField(
                "Enter tree (e.g., A->B, ...)",
                text: $viewModel.treeInput,
                axis: .vertical
            )
            .lineLimit(3...5)
            .textFieldStyle(.roundedBorder)
            .focused($isFocused)

            Text("Format: `Parent->Child`, separated by commas.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.leading, 4)

            Button("Setup Tree") {
                isFocused = false
                if let errorMessage = viewModel.setupTree() {
                    viewModel.appAlert = AppAlert(
                        title: "Invalid Input",
                        message: errorMessage
                    )
                }
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
