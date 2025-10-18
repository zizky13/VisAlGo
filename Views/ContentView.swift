import SwiftUI

enum FormFocus {
    case arrayInput, leftPointer, rightPointer, windowSize
}

struct ContentView: View {
    @StateObject var viewModel: AlgoVisualizerViewModel = .init()
    @FocusState private var focusedField: FormFocus?

    // --- MAIN VIEW BODY ---
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    Text("VisAlGo")
                        .font(.largeTitle)
                        .bold()

                    // -- VISUALIZATION AREA
                    VisualizationView(viewModel: viewModel)
                        .id("arrayVisualization")
                    
                    // -- ARRAY SETUP --
                    ArraySetupView(viewModel: viewModel, focusedField: $focusedField)

                    // -- ALGO CONTROL VIEW (ONLY SHOW IF THERE IS DATA) --
                    if !viewModel.arrayData.isEmpty {
                        AlgorithmControlsView(viewModel: viewModel, proxy: proxy, focusedField: $focusedField)
                    } else {
                        Text("Input an array value first to see controls.")
                            .font(.caption)
                    }
                }
                .padding()
            }
            // -- SHOWS ALERT IF SOMETHING IS WRONG WITH THE APP (WRONG USER INPUT, ETC.)
            .alert(item: $viewModel.appAlert) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
