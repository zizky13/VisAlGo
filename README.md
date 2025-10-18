VisAlGo

An interactive SwiftUI app for visualizing core algorithms and data structures. Explore array techniques (Two Pointers, Sliding Window, Prefix Sum) and tree traversals (BFS, DFS) with step-by-step animations, color cues, and live parameter controls.

Features
- Array visualizer: Renders values with index labels and animated color transitions.
- Algorithms with controls: Configure pointers, window size, or sample inputs; run with smooth animations.
- Tree visualizer: Enter edges like `A->B, A->C` and watch BFS/DFS with a live Queue/Stack view.
- Helpful explanations: Inline descriptions, use-cases, and one-tap sample loaders.
- Input validation: Friendly alerts for bad formats or incompatible types.

Quick Start
- Requirements: Xcode 15.4+ (or Swift Playgrounds 4.3+), iOS 16+. The package manifest targets Swift tools 6.0 and iOS 16.
- Open: In Xcode, open the folder `VisualGo.swiftpm` (File → Open…).
- Run: Select the `VisAlGo` scheme and run on an iOS Simulator (iPhone/iPad).

How To Use
- Tabs: The app has two tabs — Tree and Array.
- Array
  - Pick Data Type: Integers or Strings.
  - Enter input: e.g., `2,1,5,1,3,2` or `racecar`.
  - Tap “Setup Array” to render the array.
  - Choose Algorithm and set parameters:
    - Two Pointers: set left/right indices (palindrome demo for strings).
    - Sliding Window: set window size.
    - Prefix Sum: works only on integer arrays.
  - Tap “Load Sample Case” for a curated example, or “Run Algorithm”.
- Tree
  - Enter edges as `Parent->Child`, separated by commas. Example: `A->B, A->C, B->D, B->E, C->F, C->G`.
  - Tap “Setup Tree”, pick BFS or DFS, then “Run Algorithm”.
  - The Queue/Stack visualizer shows the traversal order.

Color Legend (Array & Tree)
- Blue: Default state
- Orange: Processing/visiting
- Green: Matched/visited
- Red: Mismatch (Two Pointers)
- Yellow: Enqueued (Tree) or newly added (Prefix Sum)
- Purple: Current window (Sliding Window)

Project Structure
- `MyApp.swift`: App entry; provides Array and Tree tabs.
- `Models/`
  - `ArrayElement.swift`: Value + color for array cells.
  - `TreeNode.swift`: Observable tree node with children and color.
  - `AppAlert.swift`: Simple alert model.
- `Protocols/`
  - `DescribableAlgo.swift`: Shared description/use-case/sample contract.
- `ViewModels/`
  - `AlgoVisualizerViewModel.swift`: App state, parsing, and algorithm animations.
- `Views/`
  - Array: `ContentView`, `VisualizationView`, `ArrayView`, `ElementView`, `ArraySetupView`, `AlgorithmControlsView`, `AlgorithmInfoView`.
  - Tree: `TreeVisualizerView`, `TreeSetupView`, `TreeAlgoControlsView`, `TreeView` (layout), `NodeView`.

Architecture
- Pattern: MVVM with a single view model (`AlgoVisualizerViewModel`) coordinating state and animations.
- Concurrency: Marked `@MainActor`; uses `Task {}` and small `Task.sleep` intervals for stepwise animation.
- UI Binding: Views bind to `@Published` state (arrays, tree root, queue/stack mirror, alerts, inputs).
- Algorithm Extensibility: Add a new case to `Algorithm` or `TreeAlgorithm`, implement the runner in the view model, and route it in `runSelectedAlgorithm`/`runSelectedTreeAlgorithm`.

Extending The App
- Add a new array algorithm
  1) Add a case to `Algorithm` with description/use case/sample.
  2) Implement `runYourAlgo()` in `AlgoVisualizerViewModel` with color updates and delays.
  3) Wire it into `runSelectedAlgorithm()`.
- Add a new tree algorithm
  1) Add a case to `TreeAlgorithm` with description/use case/sample.
  2) Implement `runYourTreeAlgo()` using the Queue/Stack mirror `structureVisualizer` for UI.
  3) Wire it into `runSelectedTreeAlgorithm()`.

Known Issues & Roadmap
- Disable switching algorithms mid-run to avoid conflicting animations.
- Speed controls (slow/normal/fast) and pause/resume.
- More array algorithms (e.g., binary search, partition/quickselect) and tree/graph variants.
- Enhanced tree layout in `TreeView` for large/deep trees.

More Docs
- See `docs/ALGORITHMS.md` for algorithm details, parameters, and complexity.
- See `docs/ARCHITECTURE.md` for MVVM, data flow, and UI notes.
