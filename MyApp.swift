import SwiftUI

@main
struct MyApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                TreeVisualizerView()
                    .tabItem {
                        Label(
                            "Tree",
                            systemImage:
                                "arrow.up.and.down.and.arrow.left.and.right"
                        )
                    }
                ContentView()
                    .tabItem {
                        Label("Array", systemImage: "rectangle.grid.1x2")
                    }
            }
        }
    }
}
