import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                QueryTextField(viewModel: viewModel)
                RepositoryList(viewModel: viewModel)
            }
            .navigationTitle("GitHubレポジトリ検索")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
