import XCTest
@testable import BookSeeker

final class SearchInteractorTests: XCTestCase {
    private lazy var searchWorkerDummy = SearchWorkerProtocolDummy()
    private lazy var searchWorkerSpy = SearchWorkerProtocolSpy()
    private lazy var searchWorkerStub = SearchWorkerProtocolStub()
    
    private lazy var historyWorkerDummy = SearchHistoryWorkerProtocolDummy()
    private lazy var historyWorkerSpy = SearchHistoryWorkerProtocolSpy()
    
    private lazy var presenterDummy = SearchPresentationLogicDummy()
    private lazy var presenterSpy = SearchPresentationLogicSpy()

    func test_searchBook_shouldCallHistoryWorkerSave_andCallSearchWorkerPerformSearch_passingCorrectTerm() {
        let term = "Some search"
        let sut = SearchInteractor(presenter: presenterDummy, historyWorker: historyWorkerSpy, searchWorker: searchWorkerSpy)
        
        sut.searchBook(request: .init(term: term))
        
        XCTAssertTrue(historyWorkerSpy.saveCalled)
        XCTAssertEqual(historyWorkerSpy.termPassed, term)
        XCTAssertTrue(searchWorkerSpy.performSearchBooksCalled)
        XCTAssertEqual(searchWorkerSpy.termPassed, term)
    }
    
    func test_searchBook_performSearchFail_shouldCallPresentSearchBookFailed() {
        let error = NSError(domain: "some error", code: 0, userInfo: nil)
        searchWorkerStub.resultToBeReturned = .failure(error)
        let sut = SearchInteractor(presenter: presenterSpy, historyWorker: historyWorkerDummy, searchWorker: searchWorkerStub)
        
        sut.searchBook(request: .init(term: "Some search"))
        
        XCTAssertTrue(presenterSpy.presentSearchBookFailedCalled)
        XCTAssertEqual(presenterSpy.presentSearchBookFailedResponsePassed?.error.localizedDescription, error.localizedDescription)
    }
    
    func test_searchBook_performSearchSucceed_shouldCallPresentSearchBookSucceed() {
        let book = Book(
            thumbArtworkUrl: "",
            artworkUrl: "apple",
            name: "ios",
            author: "apple",
            releaseDate: Date(),
            genres: [],
            descriptionHtmlText: ""
        )
        let expectedBooks = [SearchModels.Book(name: book.name, thumbArtworkUrl: book.thumbArtworkUrl)]
        let response = SearchBookResponse(books: [book])
        searchWorkerStub.resultToBeReturned = .success(response)
        let sut = SearchInteractor(presenter: presenterSpy, historyWorker: historyWorkerDummy, searchWorker: searchWorkerStub)
        
        sut.searchBook(request: .init(term: "Some search"))
        
        XCTAssertTrue(presenterSpy.presentSearchBookSucceedCalled)
        XCTAssertEqual(presenterSpy.presentSearchBookSucceedResponsePassed?.books, expectedBooks)
    }
    
    func test_fetchHistory_shouldCallHistoryWorkerFetchHistory_andPresenterPresentSearchHistory() {
        let terms = ["Charizard", "Pikachu"]
        historyWorkerSpy.fetchHistoryToBeReturn = terms
        let sut = SearchInteractor(presenter: presenterSpy, historyWorker: historyWorkerSpy, searchWorker: searchWorkerDummy)
        
        sut.fetchHistory(request: .init())
        
        XCTAssertTrue(historyWorkerSpy.fetchHistoryCalled)
        XCTAssertTrue(presenterSpy.presentSearchHistoryCalled)
        XCTAssertEqual(presenterSpy.presentSearchHistoryResponsePassed?.terms, terms)
    }
}

extension SearchModels.Book: Equatable {
    public static func == (lhs: SearchModels.Book, rhs: SearchModels.Book) -> Bool {
        return lhs.name == rhs.name &&
            lhs.thumbArtworkUrl == rhs.thumbArtworkUrl
    }
}
