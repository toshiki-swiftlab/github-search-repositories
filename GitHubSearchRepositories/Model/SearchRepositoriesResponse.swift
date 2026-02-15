struct SearchRepositoriesResponse: Codable {
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct SearchRepositoriesErrorResponse: Codable {
    let message: String
}
