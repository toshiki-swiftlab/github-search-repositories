import SwiftUI

struct RepositoryList: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            if let repositories = viewModel.repositories {
                if !repositories.isEmpty {
                    ListView(viewModel: viewModel)
                } else {
                    // []（レポジトリが見つからなかった時）
                    NotFoundView()
                }
            } else {
                // nil（初回検索前）
                Spacer()
                    .contentShape(Rectangle())
            }
        }
    }
}

private struct ListView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        List {
            Section(content: {
                ForEach(viewModel.repositories ?? [], id: \.id) { repository in
                    RepositoryCell(
                        viewModel: viewModel,
                        repository: repository
                    )
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
    }
}

private struct NotFoundView: View {
    var body: some View {
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
}

#Preview {
    RepositoryList(viewModel: ContentViewModel())
}
