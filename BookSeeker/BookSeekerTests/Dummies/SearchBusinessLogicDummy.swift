@testable import BookSeeker

final class SearchBusinessLogicDummy: SearchBusinessLogic {
    func searchBook(request: SearchModels.SearchBook.Request) {}
    
    func fetchHistory(request: SearchModels.FetchHistory.Request) {}
}
