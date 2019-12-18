@testable import BookSeeker

final class SearchBusinessLogicSpy: SearchBusinessLogic {
    private(set) var searchBookCalled = false
    private(set) var searchBookRequestPassed: SearchModels.SearchBook.Request?
    
    private(set) var fetchHistoryCalled = false
    private(set) var fetchHistoryRequestPassed: SearchModels.FetchHistory.Request?
    
    func searchBook(request: SearchModels.SearchBook.Request) {
        searchBookCalled = true
        searchBookRequestPassed = request
    }
    
    func fetchHistory(request: SearchModels.FetchHistory.Request) {
        fetchHistoryCalled = true
        fetchHistoryRequestPassed = request
    }
}
