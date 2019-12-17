@testable import BookSeeker

final class SearchPresentationLogicDummy: SearchPresentationLogic {
    func presentSearchBookFailed(response: SearchModels.SearchBook.Failure.Response) {}
    
    func presentSearchBookSucceed(response: SearchModels.SearchBook.Success.Response) {}
    
    func presentSearchHistory(response: SearchModels.FetchHistory.Response) {}
}
