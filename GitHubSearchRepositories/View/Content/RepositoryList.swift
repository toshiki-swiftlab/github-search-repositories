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
                        }, header: {
                            VStack(alignment: .leading) {
                                if let searchDetailText = viewModel.searchDetailText {
                                    Text(searchDetailText)
                                }
                                if let totalCount = viewModel.totalCount {
                                    Text("\(totalCount)件のレポジトリ")
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
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
