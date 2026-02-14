import Foundation
import Combine

@MainActor
final class ContentViewModel: ObservableObject {
    
    @Published var textFieldText = ""
    
    @Published var repositories: [Repository]?
    @Published var searchDetailText: String?
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func search() {
        if isLoading { return }
        Task {
            isLoading = true
            defer {
                searchDetailText = "クエリ（\(textFieldText)）での検索結果"
                isLoading = false
            }
            do {
                var urlComponents = URLComponents(string: SearchRepositoriesConst.searchURL)
                urlComponents?.queryItems = [
                    .init(name: "q", value: textFieldText)
                ]
                guard let url = urlComponents?.url else {
                    throw URLError(.badURL)
                }
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "GET"
                urlRequest.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
                urlRequest.setValue("application/vnd.github+json", forHTTPHeaderField: "accept")
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                let status = SearchRepositoriesConst.StatusCode(rawValue: httpResponse.statusCode)
                switch status {
                case .ok:
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decoded = try decoder.decode(SearchRepositoriesResponse.self, from: data)
                    repositories = decoded.items
                case .notModified:
                    break
                default:
                    errorMessage = status?.message ?? "予期せぬエラーが発生しました(\(httpResponse.statusCode))"
                    return
                }
            } catch {
                print(error.localizedDescription)
                errorMessage = error.localizedDescription
            }
        }
    }
    
}
