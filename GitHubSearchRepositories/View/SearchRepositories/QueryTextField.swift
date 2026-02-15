import SwiftUI

struct QueryTextField: View {
    
    @ObservedObject var viewModel: SearchRepositoriesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("クエリ入力欄")
                .font(.headline)
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("キーワード1 キーワードN 修飾子1 修飾子N", text: $viewModel.textFieldText)
                    .textFieldStyle(.plain)
                    .submitLabel(.search)
                    .onSubmit {
                        viewModel.search()
                    }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(.capsule)
        }
        .padding(.horizontal)
    }
}

#Preview {
    QueryTextField(viewModel: SearchRepositoriesViewModel())
}
