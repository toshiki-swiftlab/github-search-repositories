import SwiftUI

struct RepositoryCell: View {
    
    @ObservedObject var viewModel: ContentViewModel
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.name)
                .onAppear {
                    if repository.id == viewModel.repositories?.last?.id {
                        viewModel.search(isLoadMore: true)
                    }
                }
            Text(repository.description)
                .foregroundStyle(.secondary)
                .font(.callout)
        }
    }
}

#Preview {
    RepositoryCell(
        viewModel: ContentViewModel(),
        repository: Repository(
            id: 1,
            name: "レポジトリ名",
            description: "説明",
            url: "https://github.com/example/repo"
        )
    )
}
