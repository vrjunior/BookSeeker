import Foundation

enum BookDetailsModels {
    struct Book {
        let artworkUrl: String
        let name: String
        let author: String
        let releaseDate: Date
        let genres: [String]
        
        init(with book: BookSeeker.Book) {
            artworkUrl = book.artworkUrl
            name = book.name
            author = book.author
            releaseDate = book.releaseDate
            genres = book.genres
        }
    }
}
