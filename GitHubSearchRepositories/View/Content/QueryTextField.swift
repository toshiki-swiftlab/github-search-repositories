import SwiftUI

struct QueryTextField: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("クエリ入力欄")
                .font(.headline)
            TextField("キーワード1 キーワードN 修飾子1 修飾子N", text: $viewModel.textFieldText)
                .textFieldStyle(.plain)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(.capsule)
                .submitLabel(.search)
                .onSubmit {
                    viewModel.search()
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    QueryTextField(viewModel: ContentViewModel())
}
