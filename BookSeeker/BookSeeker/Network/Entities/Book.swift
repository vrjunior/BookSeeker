import Foundation

struct Book {
    let thumbArtworkUrl: String
    let artworkUrl: String
    let name: String
    let author: String
    let releaseDate: Date
    let genres: [String]
}

// MARK: - Decodable

extension Book: Decodable {
    private enum CodingKeys: String, CodingKey {
        case thumbArtworkUrl = "artworkUrl60"
        case artworkUrl = "artworkUrl100"
        case name = "trackName"
        case author = "artistName"
        case releaseDate
        case genres
    }
}
