protocol SearchPresentationLogic {
    func presentSearchBookFailed(response: SearchModels.SearchBook.Failure.Response)
    func presentSarchBookSucceed(response: SearchModels.SearchBook.Success.Response)
}

final class SearchPresenter {
    weak var display: SearchDisplayLogic?
}

// MARK: - SearchPresentationLogic

extension SearchPresenter: SearchPresentationLogic {
    func presentSearchBookFailed(response: SearchModels.SearchBook.Failure.Response) {
        
    }
    
    func presentSarchBookSucceed(response: SearchModels.SearchBook.Success.Response) {
        
    }
}
