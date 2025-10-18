//
//  File.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 03/08/25.
//

import SwiftUI

// -- ENUM FOR SELECTING TREE ALGO --
enum TreeAlgorithm: String, CaseIterable, Identifiable, DescribableAlgorithm {
    case bfs = "Breadth-First"
    case dfs = "Depth-First"

    var id: String { self.rawValue }
    
    var description: String {
        switch self {
        case .bfs:
            return "Explores level by level, visiting all neighbors at the present depth before moving on. It uses a Queue."
        case .dfs:
            return "Explores as far as possible down one branch before backtracking. It uses a Stack (often via recursion)."
        }
    }
    
    var useCase: String {
        switch self {
        case .bfs:
            return "Use Case: Finding the shortest path in an unweighted graph."
        case .dfs:
            return "Use Case: Finding a path in a maze or dependency resolution."
        }
    }
    
    var sampleInput: String {
        return "A->B, A->C, B->D, B->E, C->F, C->G"
    }
}

class TreeNode: Identifiable, ObservableObject {
    let id = UUID()
    var value: String
    var children: [TreeNode]
    
    @Published var color: Color = .blue
    
    init(value: String, children: [TreeNode] = []) {
        self.value = value
        self.children = children
    }
}
