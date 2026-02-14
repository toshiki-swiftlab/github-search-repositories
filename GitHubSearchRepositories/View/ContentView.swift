import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            QueryTextField(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
