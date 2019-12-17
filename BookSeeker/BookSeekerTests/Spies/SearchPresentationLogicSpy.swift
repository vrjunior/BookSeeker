@testable import BookSeeker

final class SearchPresentationLogicSpy: SearchPresentationLogic {
    private(set) var presentSearchBookFailedCalled = false
    private(set) var presentSearchBookFailedResponsePassed: SearchModels.SearchBook.Failure.Response?
    
    private(set) var presentSearchBookSucceedCalled = false
    private(set) var presentSearchBookSucceedResponsePassed: SearchModels.SearchBook.Success.Response?
    
    private(set) var presentSearchHistoryCalled = false
    private(set) var presentSearchHistoryResponsePassed: SearchModels.FetchHistory.Response?
    
    func presentSearchBookFailed(response: SearchModels.SearchBook.Failure.Response) {
        presentSearchBookFailedCalled = true
        presentSearchBookFailedResponsePassed = response
    }
    
    func presentSearchBookSucceed(response: SearchModels.SearchBook.Success.Response) {
        presentSearchBookSucceedCalled = true
        presentSearchBookSucceedResponsePassed = response
    }
    
    func presentSearchHistory(response: SearchModels.FetchHistory.Response) {
        presentSearchHistoryCalled = true
        presentSearchHistoryResponsePassed = response
    }
}
