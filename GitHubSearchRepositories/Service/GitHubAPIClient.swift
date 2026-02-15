import Foundation

struct GitHubAPIClient {
    
    func searchRepositories(query: String, page: Int) async throws -> SearchRepositoriesResponse? {
        var urlComponents = URLComponents(string: SearchRepositoriesConst.searchURL)
        urlComponents?.queryItems = [
            .init(name: "q", value: query),
            .init(name: "per_page", value: String(SearchRepositoriesConst.perPage)),
            .init(name: "page", value: String(page))
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
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        switch status {
        case .ok:
            let response = try decoder.decode(SearchRepositoriesResponse.self, from: data)
            return response
        case .notModified:
            return nil
        default:
            if let errorResponse = try? decoder.decode(SearchRepositoriesErrorResponse.self, from: data) {
                throw errorResponse
            } else {
                throw URLError(.badServerResponse)
            }
        }
    }
}
