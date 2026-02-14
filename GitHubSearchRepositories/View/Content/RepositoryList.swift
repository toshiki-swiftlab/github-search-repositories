import SwiftUI

struct RepositoryList: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            if let repositories = viewModel.repositories {
                if !repositories.isEmpty {
                    List {
                        Section(content: {
                            ForEach(viewModel.repositories ?? [], id: \.id) { repository in
                                Text(repository.name)
                            }
                        }, header: {
                            if let searchDetailText = viewModel.searchDetailText {
                                Text(searchDetailText)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        })
                    }
                    .scrollDismissesKeyboard(.interactively)
                } else {
                    VStack(spacing: 8) {
                        Spacer()
                        Image(systemName: "doc.text")
                            .font(.largeTitle)
                        Text("該当するレポジトリが見つかりませんでした。")
                            .font(.headline)
                        Spacer()
                    }
                    .bold()
                    .foregroundStyle(.gray)
                }
            } else {
                Spacer()
            }
        }
    }
}

#Preview {
    RepositoryList(viewModel: ContentViewModel())
}
