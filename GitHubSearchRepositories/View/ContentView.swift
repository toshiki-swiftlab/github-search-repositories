import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
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
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
