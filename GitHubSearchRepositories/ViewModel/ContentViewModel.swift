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
                var urlComponents = URLComponents(string: SearchRepositoriesConst.searchURL)
                urlComponents?.queryItems = [
                    .init(name: "q", value: textFieldText),
                    .init(name: "per_page", value: String(SearchRepositoriesConst.perPage)),
                    .init(name: "page", value: String(pageIndex))
                ]
                guard let url = urlComponents?.url else {
                    throw URLError(.badURL)
                }
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "GET"
                urlRequest.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
                urlRequest.setValue("application/vnd.github+json", forHTTPHeaderField: "accept")
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("📦 APIの生データ: \n\(jsonString)")
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                let status = SearchRepositoriesConst.StatusCode(rawValue: httpResponse.statusCode)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                switch status {
                case .ok:
                    let response = try decoder.decode(SearchRepositoriesResponse.self, from: data)
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
                case .notModified:
                    break
                default:
                    let response = try decoder.decode(SearchRepositoriesErrorResponse.self, from: data)
                    errorMessage = response.message
                    isErrorAlertPresented = true
                    return
                }
            } catch {
                errorMessage = error.localizedDescription
                isErrorAlertPresented = true
            }
        }
    }
    
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}
