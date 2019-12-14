protocol SearchBusinessLogic {
    func searchBook(request: SearchModels.SearchBook.Request)
}

protocol SearchDataStore {
    var books: [Book] { get set }
}

final class SearchInteractor {
    private let presenter: SearchPresentationLogic
    private let network: NetworkProtocol
    
    // MARK: - DataStore properties
    
    var books: [Book] = []
    
    init(
        presenter: SearchPresentationLogic,
        network: NetworkProtocol = Network.shared
    ) {
        self.presenter = presenter
        self.network = network
    }
}

// MARK: - SearchDataStore

extension SearchInteractor: SearchDataStore {}

// MARK: - SearchBusinessLogic

extension SearchInteractor: SearchBusinessLogic {
    func searchBook(request: SearchModels.SearchBook.Request) {
        let request = BookSearchRequest(term: request.term)
        network.requestCodable(request, dateDecodingStrategy: .iso8601) { [weak self] (result: Result<SearchBookResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.books = response.books
                let booksToPresent = response.books.map {
                    SearchModels.Book(name: $0.name, thumbArtworkUrl: $0.thumbArtworkUrl)
                }
            
                self.presenter.presentSarchBookSucceed(response: .init(books: booksToPresent))
            case .failure(let error):
                self.presenter.presentSearchBookFailed(response: .init(error: error))
            }
        }
    }
}
