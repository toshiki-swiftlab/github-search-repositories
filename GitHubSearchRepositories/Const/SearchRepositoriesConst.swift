enum SearchRepositoriesConst {
    static let searchURL = "https://api.github.com/search/repositories"
    
    static let perPage = 30
    
    enum StatusCode: Int {
        case ok = 200
        case notModified = 304
        case validationFailed = 422
        case serviceUnavailable = 503
    }
}
