import XCTest
@testable import BookSeeker

final class SearchViewControllerTests: XCTestCase {
    private lazy var viewDummy = SearchInputLogicDummy()
    private lazy var viewSpy = SearchInputLogicSpy()
    
    private lazy var routerDummy = SearchRoutingLogicDummy()
    private lazy var routerSpy = SearchRoutingLogicSpy()
    
    private lazy var interactorDummy = SearchBusinessLogicDummy()
    private lazy var interactorSpy = SearchBusinessLogicSpy()
    
    func test_init_shouldSetViewDelegate() {
        let sut = SearchViewController(customView: viewSpy, interactor: interactorDummy, router: routerDummy)
        
        XCTAssertTrue(viewSpy.delegate === sut)
    }
    
    func test_viewDidLoad_shouldCallInteractorFetchHistory() {
        let sut = SearchViewController(customView: viewDummy, interactor: interactorSpy, router: routerDummy)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(interactorSpy.fetchHistoryCalled)
        XCTAssertNotNil(interactorSpy.fetchHistoryRequestPassed)
    }
    
    func test_displaySearchBookSucceed_shouldCallViewStopLoading_andViewDisplayPassingSearchResults() {
        let books: [SearchModels.Book] = [
            .init(name: "name1", thumbArtworkUrl: "art1"),
            .init(name: "name2", thumbArtworkUrl: "art2")
        ]
        let sut = SearchViewController(customView: viewSpy, interactor: interactorDummy, router: routerDummy)
        
        sut.displaySearchBookSucceed(viewModel: .init(books: books))
        
        XCTAssertTrue(viewSpy.stopLoadingCalled)
        XCTAssertTrue(viewSpy.displayCalled)
        XCTAssertEqual(viewSpy.contentPassed, .searchResults(books: books))
    }
    
    func test_displaySearchHistory_shouldCallViewDisplayPassingSearchHistory() {
        let terms = ["Swift", "Term2"]
        let sut = SearchViewController(customView: viewSpy, interactor: interactorDummy, router: routerDummy)
        
        sut.displaySearchHistory(viewModel: .init(terms: terms))
        
        XCTAssertTrue(viewSpy.displayCalled)
        XCTAssertEqual(viewSpy.contentPassed, .searchHistory(terms: terms))
    }
    
    func test_didSelectBook_shouldCallRouterRouteToBookDetails() {
        let index = 1
        let sut = SearchViewController(customView: viewDummy, interactor: interactorDummy, router: routerSpy)
        
        sut.didSelectBook(atIndex: index)
        
        XCTAssertTrue(routerSpy.routeToBookDetailsCalled)
        XCTAssertEqual(routerSpy.indexPassed, index)
    }
    
    func test_didSelectHistoryTerm_shouldCallInteractorSearchBook() {
        let term = "Some term"
        let sut = SearchViewController(customView: viewDummy, interactor: interactorSpy, router: routerDummy)
        
        sut.didSelectHistoryTerm(term: term)
        
        XCTAssertTrue(interactorSpy.searchBookCalled)
        XCTAssertEqual(interactorSpy.searchBookRequestPassed?.term, term)
    }
    
    func test_searchBarCancelButtonClicked_shouldCallInteractorFetchHistory() {
        let searchBarDummy = UISearchBar()
        let sut = SearchViewController(customView: viewDummy, interactor: interactorSpy, router: routerDummy)
        
        sut.searchBarCancelButtonClicked(searchBarDummy)
        
        XCTAssertTrue(interactorSpy.fetchHistoryCalled)
        XCTAssertNotNil(interactorSpy.fetchHistoryRequestPassed)
    }
    
    func test_searchBarSearchButtonClicked_givenTermEmpty_shouldNotCallInteractorSearchBook() {
        let searchBarStub = UISearchBar()
        searchBarStub.text = ""
        let sut = SearchViewController(customView: viewDummy, interactor: interactorSpy, router: routerDummy)
        
        sut.searchBarSearchButtonClicked(searchBarStub)
        
        XCTAssertFalse(interactorSpy.searchBookCalled)
    }
    
    func test_searchBarSearchButtonClicked_givenTermNil_shouldNotCallInteractorSearchBook() {
        let searchBarStub = UISearchBar()
        searchBarStub.text = nil
        let sut = SearchViewController(customView: viewDummy, interactor: interactorSpy, router: routerDummy)
        
        sut.searchBarSearchButtonClicked(searchBarStub)
        
        XCTAssertFalse(interactorSpy.searchBookCalled)
    }
    
    func test_searchBarSearchButtonClicked_givenATerm_shouldCallInteractorSearchBook() {
        let term = "Some book"
        let searchBarStub = UISearchBar()
        searchBarStub.text = term
        let sut = SearchViewController(customView: viewDummy, interactor: interactorSpy, router: routerDummy)
        
        sut.searchBarSearchButtonClicked(searchBarStub)
        
        XCTAssertTrue(interactorSpy.searchBookCalled)
        XCTAssertEqual(interactorSpy.searchBookRequestPassed?.term, term)
    }
}

extension SearchView.DisplayContent: Equatable {
    public static func ==(lhs: SearchView.DisplayContent, rhs: SearchView.DisplayContent) -> Bool {
        switch(lhs, rhs) {
        case(let .searchResults(lhsBooks), let .searchResults(rhsBooks)):
            return lhsBooks == rhsBooks
        case (let .searchHistory(lhsTerms), let .searchHistory(rhsTerms)):
            return lhsTerms == rhsTerms
        default:
            return false
        }
    }
}
