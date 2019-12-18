@testable import BookSeeker

final class SearchDisplayLogicSpy: SearchDisplayLogic {
    private(set) var displaySearchBookSucceedCalled = false
    private(set) var displaySearchBookSucceedViewModelPassed: SearchModels.SearchBook.Success.ViewModel?
    
    private(set) var displaySearchBookFailedCalled = false
    private(set) var displaySearchBookFailedViewModelPassed: SearchModels.SearchBook.Failure.ViewModel?
    
    private(set) var displaySearchHistoryCalled = false
    private(set) var displaySearchHistoryViewModelPassed: SearchModels.FetchHistory.ViewModel?
    
    func displaySearchBookSucceed(viewModel: SearchModels.SearchBook.Success.ViewModel) {
        displaySearchBookSucceedCalled = true
        displaySearchBookSucceedViewModelPassed = viewModel
    }
    
    func displaySearchBookFailed(viewModel: SearchModels.SearchBook.Failure.ViewModel) {
        displaySearchBookFailedCalled = true
        displaySearchBookFailedViewModelPassed = viewModel
    }
    
    func displaySearchHistory(viewModel: SearchModels.FetchHistory.ViewModel) {
        displaySearchHistoryCalled = true
        displaySearchHistoryViewModelPassed = viewModel
    }
}
