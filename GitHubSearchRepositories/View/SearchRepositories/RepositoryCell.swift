import SwiftUI

struct RepositoryCell: View {
    
    @ObservedObject var viewModel: SearchRepositoriesViewModel
    let repository: Repository
    
    var body: some View {
        Button(action: {
            viewModel.openURL(repository.htmlUrl)
        }, label: {
            VStack(alignment: .leading) {
                Text(repository.name)
                if let description = repository.description {
                    Text(description)
                        .foregroundStyle(.secondary)
                        .font(.callout)
                        .lineLimit(3)
                }
                HStack {
                    if let language = repository.language {
                        Text(language)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.3))
                            .clipShape(.capsule)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                        Text(String(repository.stargazersCount))
                    }
                    .foregroundStyle(.yellow)
                }
            }
        })
        .foregroundStyle(.primary)
        .onAppear {
            viewModel.onLastCellAppear(repository)
        }
    }
}

#Preview {
    RepositoryCell(
        viewModel: SearchRepositoriesViewModel(),
        repository: Repository(
            id: 1,
            name: "レポジトリ名",
            description: "説明",
            htmlUrl: "https://github.com/example/repo",
            language: "Swift",
            stargazersCount: 100
        )
    )
}
