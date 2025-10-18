//
//  File.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 03/08/25.
//

// A contract for any algorithm that can be described.
protocol DescribableAlgorithm {
    var description: String { get }
    var useCase: String { get }
    var sampleInput: String { get }
}
