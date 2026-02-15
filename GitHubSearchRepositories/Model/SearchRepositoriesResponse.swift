struct SearchRepositoriesResponse: Codable {
    let totalCount: Int
    let items: [Repository]
}

struct SearchRepositoriesErrorResponse: Codable, Error {
    let message: String
}
