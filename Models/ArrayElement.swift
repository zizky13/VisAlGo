//
//  File.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 01/08/25.
//

import SwiftUI

enum DataType: String, CaseIterable, Identifiable {
    case integer = "Integers"
    case string = "Strings"

    var id: String { self.rawValue }
}

enum Algorithm: String, CaseIterable, Identifiable, DescribableAlgorithm {
    case twoPointers = "Two Pointers"
    case slidingWindow = "Sliding Window"
    case prefixSum = "Prefix Sum"

    var id: String { self.rawValue }

    // -- COMPUTED PROPS: DESCRIPTION --
    var description: String {
        switch self {
        case .twoPointers:
            return
                "This technique uses two pointers to iterate through an array. The pointers typically start at opposite ends and move towards each other, or both start at the beginning and move at different speeds. Usually, this is used to compare two elements in the array to find a specific value or pattern."
        case .slidingWindow:
            return
                "This technique involves creating a 'window' of a fixed or variable size that slides over a portion of data, often an array or string, to solve problems efficiently."
        case .prefixSum:
            return
                "A prefix sum array is a pre-computed array where each element is the sum of all elements up to that point in the original array. It helps answer range sum queries in constant time."
        }
    }

    // -- COMPUTED PROPS: USE CASE --
    var useCase: String {
        switch self {
        case .twoPointers:
            return
                "Use Case: Finding if a string is a palindrome (meaning that it reads the same forwards and backwards), or finding two numbers in a sorted array that sum to a target."
        case .slidingWindow:
            return
                "Use Case: Finding the maximum sum of a subarray of a fixed size, or finding the longest substring with no repeating characters."
        case .prefixSum:
            return
                "Use Case: Quickly finding the sum of elements in a given range (e.g., from index 2 to 5) of an array."
        }
    }

    // -- COMPUTED PROPS: SAMPLE INPUT --
    var sampleInput: String {
        switch self {
        case .twoPointers:
            return "racecar"
        case .slidingWindow:
            return "2,1,5,1,3,2"
        case .prefixSum:
            return "1,2,3,4,5"
        }
    }
}

// -- STRUCT TO DEFINE ARRAY ELEMENT (INDIVIDUAL) --
struct ArrayElement: Identifiable {
    let id = UUID()
    let value: String
    var color: Color = .blue
}
