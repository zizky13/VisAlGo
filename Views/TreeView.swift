//
//  SwiftUIView.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 03/08/25.
//

import SwiftUI

struct NodeView: View {
    @ObservedObject var node: TreeNode
    let size: CGFloat

    var body: some View {
        Circle()
            .fill(node.color)
            .frame(width: size, height: size)
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        // Post the center anchor to our "bulletin board"
                        .anchorPreference(
                            key: NodeAnchorKey.self,
                            value: .bounds
                        ) { anchor in
                            // The dictionary contains just our own ID and anchor
                            [self.node.id: anchor]
                        }
                }
            )
            .overlay(
                Text(node.value)
                    .font(.system(size: size * 0.5))
                    .foregroundColor(.white)
            )
    }
}

struct TreeView: View {
    @ObservedObject var node: TreeNode
    let depth: Int

    var body: some View {
        let nodeSize = max(60.0 - CGFloat(depth * 10), 25.0)
        
        VStack(spacing: 20) {
            NodeView(node: node, size: nodeSize)

            if !node.children.isEmpty {
                HStack(alignment: .top, spacing: 15) {
                    ForEach(node.children) { child in
                        TreeView(node: child, depth: depth + 1)
                    }
                }
            }
        }
        .backgroundPreferenceValue(NodeAnchorKey.self) { anchors in
            GeometryReader { geometry in
                if let parentAnchor = anchors[self.node.id] {
                    ForEach(self.node.children) { child in
                        if let childAnchor = anchors[child.id] {
                            Path { path in
                                path.move(to: geometry[parentAnchor].center)
                                path.addLine(to: geometry[childAnchor].center)
                            }
                            .stroke(Color.gray, lineWidth: 2)
                        }
                    }
                }
            }
        }

    }
}

struct NodeAnchorKey: PreferenceKey {
    // The data we are collecting: a dictionary of node IDs and their center points.
    typealias Value = [UUID: Anchor<CGRect>]

    // Use `let` to define an immutable, concurrency-safe default value.
    static let defaultValue: Value = [:]

    // This function is now also safe because it doesn't access mutable global state.
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue()) { $1 }
    }
}

extension CGRect {
    public var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
