enum SearchRepositoriesConst {
    static let searchURL = "https://api.github.com/search/repositories"
    
    enum StatusCode: Int {
        case ok = 200
        case notModified = 304
        case validationFailed = 422
        case serviceUnavailable = 503
        
        var message: String {
            switch self {
            case .ok: return ""
            case .notModified: return ""
            case .validationFailed: return "クエリが無効です。"
            case .serviceUnavailable: return "GitHubがメンテナンス中か、混み合っています。時間を置いてお試しください。"
            default: return "予期せぬエラーが発生しました。"
            }
        }
    }
}
