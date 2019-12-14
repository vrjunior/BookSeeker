import Foundation

struct SearchBookResponse {
    let books: [Book]
}

// MARK: - Decodable

extension SearchBookResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case books = "results"
    }
}
