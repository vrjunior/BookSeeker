import XCTest
@testable import BookSeeker

final class SearchPresenterTests: XCTestCase {
    private let displaySpy = SearchDisplayLogicSpy()
    private let sut = SearchPresenter()
    
    override func setUp() {
        super.setUp()
        sut.display = displaySpy
    }
    
    func test_presentSearchBookFailed_shouldCallDisplaySearchBookFailed() {
        let error = NSError()
        
        sut.presentSearchBookFailed(response: .init(error: error))
        
        XCTAssertTrue(displaySpy.displaySearchBookFailedCalled)
        XCTAssertEqual(displaySpy.displaySearchBookFailedViewModelPassed?.errorMessage, Localization.GenericError.LocalizedMessage.text)
    }
    
    func test_presentSearchBookSucceed_shouldCallDisplaySearchBookSucceed() {
        let books = [SearchModels.Book(name: "some name", thumbArtworkUrl: "url")]
        
        sut.presentSearchBookSucceed(response: .init(books: books))
        
        XCTAssertTrue(displaySpy.displaySearchBookSucceedCalled)
        XCTAssertEqual(displaySpy.displaySearchBookSucceedViewModelPassed?.books, books)
    }
    
    func test_presentSearchHistory_shouldCallDisplaySearchHistory() {
        let historyTerms = ["Swift", "UI"]
        
        sut.presentSearchHistory(response: .init(terms: historyTerms))
        
        XCTAssertTrue(displaySpy.displaySearchHistoryCalled)
        XCTAssertEqual(displaySpy.displaySearchHistoryViewModelPassed?.terms, historyTerms)
    }
}
