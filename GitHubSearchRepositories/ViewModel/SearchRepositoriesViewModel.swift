import Combine
import UIKit

@MainActor
final class SearchRepositoriesViewModel: ObservableObject {
    
    @Published var textFieldText = ""
    @Published var pageNumber = 1
    
    @Published var repositories: [Repository]?
    @Published var searchDetailText: String?
    /// 検索総ヒット数
    @Published var totalCount: Int?
    
    @Published var isLoading = false
    @Published var canLoadMore = true
    @Published var errorMessage: String?
    @Published var isErrorAlertPresented = false
    
    func search(isLoadMore: Bool = false) {
        if isLoading { return }
        if textFieldText == "" { return }
        if isLoadMore && !canLoadMore { return }
        if !isLoadMore {
            pageNumber = 1
            canLoadMore = true
        }
        Task {
            isLoading = true
            defer {
                searchDetailText = "クエリ（\(textFieldText)）での検索結果"
                isLoading = false
            }
            do {
                let response = try await GitHubAPIClient().searchRepositories(query: textFieldText, page: pageNumber)
                // response: nilは、"notModified"ステータスコードの時のみであり、成功処理も失敗処理もしない。
                guard let response else { return }
                if pageNumber == 1 {
                    repositories = response.items
                } else {
                    repositories?.append(contentsOf: response.items)
                }
                pageNumber += 1
                if response.items.count < SearchRepositoriesConst.perPage || response.totalCount == repositories?.count {
                    canLoadMore = false
                }
                totalCount = response.totalCount
            } catch {
                errorMessage = error.localizedDescription
                isErrorAlertPresented = true
            }
        }
    }
    
    /// 最後尾のセルが表示された時の処理
    /// - 再読み込み処理を実行
    func onLastCellAppear(_ repository: Repository) {
        if repository.id == repositories?.last?.id {
            search(isLoadMore: true)
        }
    }
    
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
