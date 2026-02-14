import SwiftUI

struct QueryTextField: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
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

#Preview {
    QueryTextField(viewModel: ContentViewModel())
}
