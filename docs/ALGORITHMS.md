Algorithms

This app visualizes several algorithms with step-by-step animations. Each animation updates element/node colors and, where applicable, mirrors the underlying data structure (Queue/Stack) into `structureVisualizer` for display.

Array Algorithms
- Two Pointers (Palindrome demo)
  - Idea: Move two pointers inward from ends; compare at each step.
  - Parameters: `left index`, `right index` (auto-filled for samples).
  - Input: Typically strings (e.g., `racecar`). Works with indices for arrays, but the mismatch demo is most illustrative for strings.
  - Animation: Active elements turn Orange; matches turn Green; a mismatch becomes Red and stops.
  - Complexity: O(n) time, O(1) space.

- Sliding Window
  - Idea: Maintain a fixed-size window and slide across the array.
  - Parameters: `window size`.
  - Input: Integers or strings split by commas (e.g., `2,1,5,1,3,2`).
  - Animation: Current window turns Purple; previous leading element resets to its original color.
  - Complexity: O(n) time, O(1) extra space (not counting input/output).

- Prefix Sum
  - Idea: Compute a cumulative sum array where `prefix[i] = sum(0...i)`.
  - Parameters: none.
  - Input: Integers only (e.g., `1,2,3,4,5`).
  - Animation: Each processed item turns Orange; new prefix item appears Yellow then settles to Cyan; original colors are restored at the end.
  - Complexity: O(n) time, O(n) space for the prefix array.

Tree Algorithms
- Breadth-First Search (BFS)
  - Idea: Visit nodes level-by-level using a queue.
  - Input: Edges as `Parent->Child`, comma-separated (e.g., `A->B, A->C, B->D, B->E`).
  - Animation: Enqueued nodes are Yellow; visiting node becomes Orange; visited nodes become Green. The Queue view updates in lockstep.
  - Complexity: O(V + E) time, O(V) space.

- Depth-First Search (DFS)
  - Idea: Explore as far as possible down a branch before backtracking, using a stack (recursion or explicit).
  - Input: Same as BFS.
  - Animation: Nodes push onto a Stack view; current node turns Orange, then Green when fully visited.
  - Complexity: O(V + E) time, O(V) space (stack depth in worst case).

Input Formats
- Arrays: For integers, use comma-separated numbers. For strings, either a single string (e.g., `racecar`) or comma-separated tokens.
- Trees: Use `Parent->Child` pairs, comma-separated. Whitespace is ignored. Example: `A->B, A->C, B->D, B->E, C->F, C->G`.

Color Legend
- Blue: Default
- Orange: Processing/visiting
- Green: Matched/visited
- Red: Mismatch (Two Pointers)
- Yellow: Enqueued/newly-added
- Purple: Current window (Sliding Window)

Tips
- Use the “Load Sample Case” button for each algorithm to quickly populate valid inputs and parameters.
- For arrays, ensure integers for Prefix Sum; the app validates and shows an alert if parsing fails.

