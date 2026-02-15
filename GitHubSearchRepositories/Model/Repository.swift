/// GitHubのレポジトリ
/// - /search/repositoriesエンドポイントのitemsレスポンスの要素
struct Repository: Codable {
    let id: Int
    /// レポジトリ名
    let name: String
    let description: String?
    /// レポジトリURL
    let htmlUrl: String
    let language: String?
    let stargazersCount: Int
}
