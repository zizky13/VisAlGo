//
//  SwiftUIView.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 03/08/25.
//

import SwiftUI

struct TreeVisualizerView: View {
    @StateObject var viewModel: AlgoVisualizerViewModel = .init()
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    Text("VisAlGo").font(.largeTitle).bold()

                    //-- VISUALIZATION VIEW --
                    if let root = viewModel.rootNode {
                            GeometryReader { geometry in
                                Spacer()
                                HStack {
                                    TreeView(node: root, depth: 0)
                                        .id("treeVisualization")
                                }
                                // 2. Force the HStack to be at least as wide as the screen.
                                .frame(minWidth: geometry.size.width)
                                Spacer()
                            }
                            .frame(height: 200)
                    }

                    VStack {
                        if viewModel.structureVisualizer.isEmpty {
                            Text("[ Empty ]").foregroundColor(.secondary)
                                .italic()
                        } else {
                            Text("\(viewModel.structureTitle):").font(.headline)
                            GeometryReader { geometry in
                                ScrollView(.horizontal, showsIndicators: false)
                                {

                                    HStack(spacing: 8) {
                                        let content =
                                            viewModel.structureTitle == "Queue"
                                            ? viewModel.structureVisualizer
                                            : viewModel.structureVisualizer
                                                .reversed()

                                        Spacer()
                                        ForEach(
                                            content,
                                            id: \.self
                                        ) { value in
                                            Text(value)
                                                .font(
                                                    .system(
                                                        size: 20,
                                                        design: .monospaced
                                                    )
                                                )
                                                .padding(8)
                                                .background(
                                                    Color.yellow.opacity(0.3)
                                                )
                                                .cornerRadius(4)
                                        }
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .frame(minWidth: geometry.size.width)
                                }
                            }
                            .frame(height: 50)
                        }
                    }
                    .frame(height: 60)

                    //-- TREE SETUP VIEW (USER INPUT) --
                    TreeSetupView(
                        viewModel: viewModel,
                        isFocused: $isTextFieldFocused
                    )

                    //-- TREE ALGO CONTROL --
                    if viewModel.rootNode != nil {
                        TreeAlgoControlsView(viewModel: viewModel, proxy: proxy)
                    }
                }
                .padding()
            }
            .onAppear {
                if viewModel.rootNode == nil {
                    viewModel.setupTree()
                }
            }
        }
    }

    // The controls can remain here as a subview
}
