//
//  File.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 02/08/25.
//

import Combine
import SwiftUI

@MainActor
class AlgoVisualizerViewModel: ObservableObject {
    @Published var arrayData: [ArrayElement]
    @Published var prefixSumData: [ArrayElement]
    @Published var selectedType: DataType
    @Published var arrayInput: String
    @Published var leftPointerInput: String
    @Published var rightPointerInput: String
    @Published var windowSizeInput: String
    @Published var selectedAlgorithm: Algorithm
    @Published var appAlert: AppAlert?
    @Published var rootNode: TreeNode?
    @Published var selectedTreeAlgorithm: TreeAlgorithm
    @Published var structureVisualizer: [String]
    @Published var structureTitle: String
    @Published var treeInput: String

    init() {
        self.arrayData = []
        self.prefixSumData = []
        self.selectedType = .integer
        self.arrayInput = ""
        self.leftPointerInput = ""
        self.rightPointerInput = ""
        self.windowSizeInput = ""
        self.selectedAlgorithm = .twoPointers
        self.appAlert = nil
        self.structureVisualizer = []
        self.structureTitle = "Queue"
        self.selectedTreeAlgorithm = .bfs
        self.treeInput = ""
    }

    func setupTree() -> String? {
        var nodes: [String: TreeNode] = [:]
        var firstNode: TreeNode?

        // Helper to get or create a node
        func getNode(with value: String) -> TreeNode {
            if let existingNode = nodes[value] {
                return existingNode
            } else {
                let newNode = TreeNode(value: value)
                nodes[value] = newNode
                if firstNode == nil {
                    firstNode = newNode
                }
                return newNode
            }
        }

        // Clear previous children before parsing new ones
        nodes.values.forEach { $0.children = [] }

        let connections = treeInput.split(separator: ",").map {
            $0.trimmingCharacters(in: .whitespaces)
        }

        for connection in connections {
            let parts = connection.components(separatedBy: "->")

            // Check for the correct number of parts
            guard parts.count == 2 else {
                return
                    "Invalid format: '\(connection)'. Should be 'Parent->Child'."
            }

            let parentValue = parts[0].trimmingCharacters(in: .whitespaces)
            let childValue = parts[1].trimmingCharacters(in: .whitespaces)

            // Check for empty names
            guard !parentValue.isEmpty, !childValue.isEmpty else {
                return
                    "Invalid format: Node names cannot be empty in '\(connection)'."
            }

            let parentNode = getNode(with: parentValue)
            let childNode = getNode(with: childValue)

            parentNode.children.append(childNode)
        }

        self.rootNode = firstNode
        resetTreeColors(node: self.rootNode)

        return nil  // Return nil to indicate success
    }

    func runSelectedTreeAlgorithm() {
        Task {
            // Reset the tree before running a new animation
            resetTreeColors(node: rootNode)

            switch selectedTreeAlgorithm {
            case .bfs:
                self.structureTitle = "Queue"
                runBFS()  // You already have this
            case .dfs:
                self.structureTitle = "Stack"
                runDFS()  // We will add this
            }
        }
    }

    private func runDFS() {
        guard let startNode = rootNode else { return }

        Task {
            var stack = [startNode]

            // Use a set to track visited nodes
            var visited = Set<UUID>()

            // --- THE FIX IS HERE ---
            // Initialize the visualizer to match the actual stack.
            self.structureVisualizer = [startNode.value]

            while !stack.isEmpty {
                // Now it's safe to remove from both arrays because they are in sync.
                let currentNode = stack.removeLast()
                self.structureVisualizer.removeLast()

                guard !visited.contains(currentNode.id) else { continue }

                // Mark as "visiting"
                withAnimation {
                    currentNode.color = .orange
                }
                visited.insert(currentNode.id)
                try? await Task.sleep(for: .seconds(1))

                // Push children onto the stack in reverse order
                for child in currentNode.children.reversed() {
                    if !visited.contains(child.id) {
                        stack.append(child)
                        self.structureVisualizer.append(child.value)
                    }
                }

                // Mark current node as "visited"
                withAnimation {
                    currentNode.color = .green
                }
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }

    func runBFS() {
        guard let startNode = rootNode else { return }

        Task {
            // Reset tree and queue visualizer
            resetTreeColors(node: startNode)
            self.structureVisualizer = []

            var queue = [startNode]
            var visited = Set<UUID>()

            // Mark the starting node as "queued"
            startNode.color = .yellow
            self.structureVisualizer.append(startNode.value)
            try? await Task.sleep(for: .seconds(1))

            while !queue.isEmpty {
                let currentNode = queue.removeFirst()

                // Update UI to show it's being dequeued
                self.structureVisualizer.removeFirst()

                guard !visited.contains(currentNode.id) else { continue }

                // Mark as "visiting"
                withAnimation {
                    currentNode.color = .orange
                }
                try? await Task.sleep(for: .seconds(1))

                // Enqueue all children
                for child in currentNode.children {
                    if !visited.contains(child.id) {
                        queue.append(child)
                        // Mark children as "queued"
                        withAnimation {
                            child.color = .yellow
                        }
                        self.structureVisualizer.append(child.value)
                    }
                }

                // Mark current node as "visited"
                withAnimation {
                    currentNode.color = .green
                }
                visited.insert(currentNode.id)
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }

    private func resetTreeColors(node: TreeNode?) {
        guard let node = node else { return }
        node.color = .blue
        for child in node.children {
            resetTreeColors(node: child)
        }
    }

    func setupArray() {
        let trimmedInput = arrayInput.trimmingCharacters(in: .whitespaces)
        var stringValues: [String] = []

        switch selectedType {
        case .integer:
            stringValues = trimmedInput.split(separator: ",").map {
                $0.trimmingCharacters(in: .whitespaces)
            }.filter { Int($0) != nil }
        case .string:
            if trimmedInput.contains(",") {
                stringValues = trimmedInput.split(separator: ",").map {
                    String($0.trimmingCharacters(in: .whitespaces))
                }
            } else {
                stringValues = trimmedInput.map { String($0) }
            }
        }

        withAnimation {
            self.arrayData = stringValues.map { ArrayElement(value: $0) }
            self.prefixSumData = []
        }
    }

    func runTwoPointers(startLeft: Int, startRight: Int) async {
        // --- Setup and Validation ---
        guard startLeft >= 0, startRight < arrayData.count,
            startLeft <= startRight
        else {
            self.appAlert = AppAlert(
                title: "Invalid Input",
                message: "Pointer positions are out of bounds."
            )
            return
        }

        var left = startLeft
        var right = startRight
        var isMatch = true  // A flag to track if we've found a mismatch

        if selectedType == .string {
            while left < right {
                // Highlight the pointers we are comparing
                await MainActor.run {
                    withAnimation(.easeInOut) {
                        arrayData[left].color = .orange
                        arrayData[right].color = .orange
                    }
                }
                try? await Task.sleep(for: .seconds(1))

                // --- The Core Logic: Compare the values ---
                if arrayData[left].value == arrayData[right].value {
                    // MATCH FOUND: Turn them green and continue
                    await MainActor.run {
                        withAnimation(.easeInOut) {
                            arrayData[left].color = .green
                            arrayData[right].color = .green
                        }
                    }

                    // Move pointers inward
                    left += 1
                    right -= 1
                } else {
                    // MISMATCH: Turn them red, set the flag, and stop the loop
                    isMatch = false
                    await MainActor.run {
                        withAnimation(.easeInOut) {
                            arrayData[left].color = .red
                            arrayData[right].color = .red
                        }
                    }
                    // The `break` keyword immediately exits the while loop
                    break
                }

                try? await Task.sleep(for: .seconds(1))
            }

            if isMatch {
                // If the loop finished without a mismatch, it's a palindrome!
                withAnimation {
                    // Turn the whole array green to show success
                    for i in 0..<arrayData.count {
                        arrayData[i].color = .green
                    }
                    // Also show a success alert
                    self.appAlert = AppAlert(
                        title: "Success!",
                        message: "The input is a palindrome."
                    )
                }
            } else {
                self.appAlert = AppAlert(
                    title: "Mismatch Found",
                    message: "The input is not a palindrome."
                )
            }

        } else {
            while left < right {
                withAnimation {
                    arrayData[left].color = .orange
                    arrayData[right].color = .orange
                }

                try? await Task.sleep(for: .seconds(1))

                withAnimation {
                    arrayData[left].color = .green
                    arrayData[right].color = .green
                }

                try? await Task.sleep(for: .seconds(1))

                left += 1
                right -= 1
            }
        }
        // --- Final Result Visualization ---
        try? await Task.sleep(for: .seconds(1.5))

        for i in 0..<arrayData.count {
            withAnimation {
                arrayData[i].color = .blue
            }
        }
    }  //Function to run two pointer algo

    func runSlidingWindow(size: Int) async {
        guard size > 0 && size <= arrayData.count else {
            self.appAlert = AppAlert(
                title: "Invalid Window Size",
                message:
                    "Window size must be greater than 0 and not larger than the array."
            )
            return
        }

        let originalColors = arrayData.map { $0.color }

        for i in 0...(arrayData.count - size) {

            // --- Highlight the current window ---
            withAnimation(.easeInOut) {
                for j in 0..<size {
                    arrayData[i + j].color = .purple  // A new color for our window
                }
            }

            // In a real algorithm, you'd process the window here.

            try? await Task.sleep(for: .seconds(1.5))

            // --- Reset the first element of the window to prepare for the slide ---
            // (Unless it's the very last step)
            if i < arrayData.count - size {
                withAnimation(.easeInOut) {
                    arrayData[i].color = originalColors[i]
                }
            }
            try? await Task.sleep(for: .seconds(0.5))
        }

        // --- Cleanup: Reset all colors ---
        try? await Task.sleep(for: .seconds(2))
        withAnimation {
            for i in 0..<arrayData.count {
                arrayData[i].color = originalColors[i]
            }
        }
    }

    func runPrefixSum() async {
        // --- Error Handling ---
        guard !arrayData.isEmpty else {
            self.appAlert = AppAlert(
                title: "Array Empty",
                message: "Please set up an array first."
            )
            return
        }

        // --- CORRECTED SECTION ---
        // First, attempt to convert all values to numbers.
        let numbers = arrayData.compactMap({ Int($0.value) })
        let originalColors = arrayData.map { $0.color }

        // Now, guard to ensure every single element was a valid number.
        guard numbers.count == arrayData.count else {
            self.appAlert = AppAlert(
                title: "Invalid Type",
                message: "Prefix Sum can only be run on an array of integers."
            )
            return
        }

        // Reset the result array
        withAnimation {
            prefixSumData = []
        }
        try? await Task.sleep(for: .seconds(0.5))

        var runningSum = 0
        // --- Build the prefix sum array step-by-step ---
        for (index, number) in numbers.enumerated() {
            // Highlight the element being processed in the original array
            withAnimation {
                arrayData[index].color = .orange
            }

            runningSum += number

            // Create the new element for our result array
            let newElement = ArrayElement(
                value: "\(runningSum)",
                color: .yellow
            )

            withAnimation(.spring()) {
                prefixSumData.append(newElement)
            }

            try? await Task.sleep(for: .seconds(1))
            withAnimation {
                prefixSumData[index].color = .cyan
            }

            try? await Task.sleep(for: .seconds(1))

            // Reset the color of the processed element

        }

        withAnimation {
            for i in 0..<arrayData.count {
                arrayData[i].color = originalColors[i]
            }
        }
    }

    func runSelectedAlgorithm() {
        Task {
            switch self.selectedAlgorithm {
            case .twoPointers:
                let left = Int(self.leftPointerInput) ?? 0
                let right =
                    Int(self.rightPointerInput) ?? (self.arrayData.count - 1)
                await self.runTwoPointers(startLeft: left, startRight: right)
            case .slidingWindow:
                let windowSize = Int(self.windowSizeInput) ?? 3
                await self.runSlidingWindow(size: windowSize)
            case .prefixSum:
                await self.runPrefixSum()
            }
        }
    }

    func loadSample(for algorithm: DescribableAlgorithm) {
        // Check if the passed-in algorithm is for Arrays
        if let arrayAlgorithm = algorithm as? Algorithm {
            self.arrayInput = arrayAlgorithm.sampleInput

            // Set the specific parameters for the array algorithm
            switch arrayAlgorithm {
            case .twoPointers:
                self.leftPointerInput = "0"
                self.rightPointerInput = "6"
                self.windowSizeInput = ""
            case .slidingWindow:
                self.windowSizeInput = "3"
                self.leftPointerInput = ""
                self.rightPointerInput = ""
            case .prefixSum:
                self.leftPointerInput = ""
                self.rightPointerInput = ""
                self.windowSizeInput = ""
            }
            setupArray()

            // Check if the passed-in algorithm is for Trees
        } else if let treeAlgorithm = algorithm as? TreeAlgorithm {
            self.treeInput = treeAlgorithm.sampleInput
            setupTree()
        }
    }

}
