protocol SearchBusinessLogic {
    func searchBook(request: SearchModels.SearchBook.Request)
    func fetchHistory(request: SearchModels.FetchHistory.Request)
}

protocol SearchDataStore {
    var books: [Book] { get set }
}

final class SearchInteractor {
    private let presenter: SearchPresentationLogic
    private let searchWorker: SearchWorkerProtocol
    private let historyWorker: SearchHistoryWorkerProtocol
    
    // MARK: - DataStore properties
    
    var books: [Book] = []
    
    init(
        presenter: SearchPresentationLogic,
        historyWorker: SearchHistoryWorkerProtocol,
        searchWorker: SearchWorkerProtocol
    ) {
        self.presenter = presenter
        self.historyWorker = historyWorker
        self.searchWorker = searchWorker
    }
}

// MARK: - SearchDataStore

extension SearchInteractor: SearchDataStore {}

// MARK: - SearchBusinessLogic

extension SearchInteractor: SearchBusinessLogic {
    func searchBook(request: SearchModels.SearchBook.Request) {
        
        historyWorker.save(term: request.term)
        
        searchWorker.performSearchBooks(term: request.term) { [weak self] (result: Result<SearchBookResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.books = response.books
                let booksToPresent = response.books.map {
                    SearchModels.Book(name: $0.name, thumbArtworkUrl: $0.thumbArtworkUrl)
                }
            
                self.presenter.presentSearchBookSucceed(response: .init(books: booksToPresent))
            case .failure(let error):
                self.presenter.presentSearchBookFailed(response: .init(error: error))
            }
        }
    }
    
    func fetchHistory(request: SearchModels.FetchHistory.Request) {
        let terms = historyWorker.fetchHistory()
        presenter.presentSearchHistory(response: .init(terms: terms))
    }
}
