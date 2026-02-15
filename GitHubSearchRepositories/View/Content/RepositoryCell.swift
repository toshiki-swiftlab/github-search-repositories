import SwiftUI

struct RepositoryCell: View {
    
    @ObservedObject var viewModel: ContentViewModel
    let repository: Repository
    
    var body: some View {
        Button(action: {
            viewModel.openURL(repository.htmlUrl)
        }, label: {
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
                Text(repository.language)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.3))
                    .clipShape(.capsule)
            }
        })
        .foregroundStyle(.primary)
    }
}

#Preview {
    RepositoryCell(
        viewModel: ContentViewModel(),
        repository: Repository(
            id: 1,
            name: "レポジトリ名",
            description: "説明",
            htmlUrl: "https://github.com/example/repo",
            language: "Swift"
        )
    )
}
