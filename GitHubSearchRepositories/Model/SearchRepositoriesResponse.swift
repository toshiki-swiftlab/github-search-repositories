/// GitHubの/search/repositoriesエンドポイントの成功時レスポンス
struct SearchRepositoriesResponse: Codable {
    /// 検索ヒット総数
    let totalCount: Int
    /// レポジトリ一覧
    let items: [Repository]
}

/// GitHubの/search/repositoriesエンドポイントの失敗時レスポンス
struct SearchRepositoriesErrorResponse: Codable, Error {
    let message: String
}
