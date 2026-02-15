import Foundation
import SwiftUI
import Combine

@MainActor
final class ContentViewModel: ObservableObject {
    
    @Published var textFieldText = ""
    @Published var pageIndex = 1
    
    @Published var repositories: [Repository]?
    @Published var searchDetailText: String?
    @Published var totalCount: Int?
    
    @Published var isLoading = false
    @Published var canLoadMore = true
    @Published var errorMessage: String?
    @Published var isErrorAlertPresented = false
    
    func search(isLoadMore: Bool = false) {
        if isLoading { return }
        if textFieldText == "" { return }
        if !isLoadMore {
            pageIndex = 1
            canLoadMore = true
        }
        Task {
            isLoading = true
            defer {
                searchDetailText = "クエリ（\(textFieldText)）での検索結果"
                isLoading = false
            }
            do {
                let response = try await GitHubAPIClient().searchRepositories(query: textFieldText, page: pageIndex)
                guard let response else { return }
                if pageIndex == 1 {
                    repositories = response.items
                } else {
                    repositories?.append(contentsOf: response.items)
                }
                pageIndex += 1
                if response.items.count < SearchRepositoriesConst.perPage {
                    canLoadMore = false
                }
                totalCount = response.totalCount
            } catch {
                errorMessage = error.localizedDescription
                isErrorAlertPresented = true
            }
        }
    }
    
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
