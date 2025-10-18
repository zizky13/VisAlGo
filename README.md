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


Screenshots
![freeimgen_1760792273706](https://github.com/user-attachments/assets/beb2de45-ab81-4d4a-9282-f4f49f0d7f74)
![freeimgen_1760792277050](https://github.com/user-attachments/assets/080bb839-947e-4a09-afd5-bbcbce7b2179)
![freeimgen_1760792280582](https://github.com/user-attachments/assets/2616588f-6714-4db5-9771-12a5c26ac559)
![freeimgen_1760792283605](https://github.com/user-attachments/assets/92985da9-cf44-4543-89ec-ced1aa96a117)
![freeimgen_1760792286270](https://github.com/user-attachments/assets/acdfa843-843d-42bf-bb6f-724f0ce5a295)
![freeimgen_1760792289127](https://github.com/user-attachments/assets/0f23ab21-f2f8-4ad2-a404-344c9d2c4459)
![freeimgen_1760792291830](https://github.com/user-attachments/assets/71fd2459-20ad-4ef5-b89c-517668874faf)
![freeimgen_1760792295020](https://github.com/user-attachments/assets/9b1a5c5a-719c-454d-9304-9d1e554a3c6d)
![freeimgen_1760792298025](https://github.com/user-attachments/assets/29cd36b3-764e-4cfe-a1aa-592a60d1b00f)
![freeimgen_1760792301490](https://github.com/user-attachments/assets/77dd5c71-3bca-4e29-9b8f-0953eb2c1632)
![freeimgen_1760792304491](https://github.com/user-attachments/assets/136e17c3-2f38-4677-915e-5b0376d22c29)
![freeimgen_1760792307345](https://github.com/user-attachments/assets/bd2b8c28-d7bd-49d8-93ff-f80daf8a51b1)
![freeimgen_1760792310007](https://github.com/user-attachments/assets/728c1de7-dfc8-4671-abc3-74287fe92f63)
![freeimgen_1760792312748](https://github.com/user-attachments/assets/d972ff76-6261-4e5b-af03-a780c9406c0f)



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
