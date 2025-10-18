Architecture

Overview
- Pattern: MVVM. Views are dumb UI; `AlgoVisualizerViewModel` holds state and runs algorithm steps.
- Platform: SwiftUI, iOS 16+ target, Swift tools 6.0 manifest.
- Concurrency: `@MainActor` view model; algorithms run in `Task {}` with brief `Task.sleep` delays to pace animations.

Modules
- Models
  - `ArrayElement`: Identifiable value + `Color` (render state).
  - `TreeNode`: Identifiable, `ObservableObject` node with `children` and `Color`.
  - `AppAlert`: Simple Identifiable for SwiftUI `.alert(item:)`.
- Protocols
  - `DescribableAlgorithm`: Shared fields `description`, `useCase`, `sampleInput` for both array and tree algorithms.
- Enums (Algorithms)
  - `Algorithm`: `.twoPointers`, `.slidingWindow`, `.prefixSum`.
  - `TreeAlgorithm`: `.bfs`, `.dfs`.
- ViewModel
  - `AlgoVisualizerViewModel`: Publishes all UI state: array contents/colors, prefix sum output, selected algorithm, inputs (pointers/window), tree root, active tree algorithm, Queue/Stack mirror (`structureVisualizer`), and alerts.
  - Array setup: Parses input by `DataType` (integer vs string) and populates `[ArrayElement]`.
  - Tree setup: Parses `Parent->Child` edges, deduplicates/creates `TreeNode`s, wires children, sets `rootNode`, resets colors.
  - Execution: Routes to the selected algorithm; each runner updates colors and structure mirror with animation.
- Views
  - Array: `ContentView` (container), `VisualizationView` (array + prefix sum rows), `ArrayView` + `ElementView`, `ArraySetupView`, `AlgorithmControlsView`, `AlgorithmInfoView`.
  - Tree: `TreeVisualizerView`, `TreeSetupView`, `TreeAlgoControlsView`, `TreeView` (node layout), `NodeView` (draws node and exports anchor).

Data Flow
1) User edits inputs (array values, edges, parameters) → `@Published` fields update.
2) Setup actions (`setupArray`, `setupTree`) parse and populate view model state (elements, nodes) and reset colors.
3) Run action spawns a `Task` that steps the algorithm, pacing with `Task.sleep`, updating colors and `structureVisualizer`.
4) Views bind to `@Published` values and animate transitions.

Animation & Threading
- All state lives on the main actor; UI updates use `withAnimation` blocks for smooth transitions.
- Small sleeps (0.5–2.0s) create visible steps; adjust to tune speed.

Extensibility
- New array algorithm
  - Add enum case with description/use case/sample.
  - Implement a `runX()` method that mutates `arrayData` colors step-by-step.
  - Add a branch in `runSelectedAlgorithm()` and any parameter UI.
- New tree algorithm
  - Add enum case and description/use case/sample.
  - Implement a `runX()` that mutates node colors and appends/removes values from `structureVisualizer` to keep the Queue/Stack view in sync.
  - Add a branch in `runSelectedTreeAlgorithm()`.

Notes & Limitations
- Algorithm switching during a run is not yet disabled; consider locking controls or adding a cancel token.
- `TreeView` layout can be enhanced for larger/deeper trees (e.g., compute x/y with breadth spacing by depth).
- Prefix Sum enforces integer inputs; other algorithms support either integers or strings (per-UI hints).

