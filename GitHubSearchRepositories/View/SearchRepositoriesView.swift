import SwiftUI

struct SearchRepositoriesView: View {
    
    @StateObject var viewModel = SearchRepositoriesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    QueryTextField(viewModel: viewModel)
                    RepositoryList(viewModel: viewModel)
                }
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationTitle("GitHubレポジトリ検索")
            .navigationBarTitleDisplayMode(.inline)
            .alert(
                "エラー",
                isPresented: $viewModel.isErrorAlertPresented,
                presenting: viewModel.errorMessage,
                actions: { _ in },
                message: { erroeMessage in
                    Text(erroeMessage)
                }
            )
        }
    }
}

#Preview {
    SearchRepositoriesView(viewModel: SearchRepositoriesViewModel())
}
