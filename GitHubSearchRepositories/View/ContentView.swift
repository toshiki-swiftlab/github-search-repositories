import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            TextField("クエリを入力して下さい！", text: $viewModel.textFieldText)
                .textFieldStyle(.plain)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(.capsule)
                .padding(.horizontal)
                .submitLabel(.search)
                .onSubmit {
                    viewModel.search()
                }
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
