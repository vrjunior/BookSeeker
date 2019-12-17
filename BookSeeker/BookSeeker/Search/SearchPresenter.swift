protocol SearchPresentationLogic {
    func presentSearchBookFailed(response: SearchModels.SearchBook.Failure.Response)
    func presentSearchBookSucceed(response: SearchModels.SearchBook.Success.Response)
    func presentSearchHistory(response: SearchModels.FetchHistory.Response)
}

final class SearchPresenter {
    weak var display: SearchDisplayLogic?
}

// MARK: - SearchPresentationLogic

extension SearchPresenter: SearchPresentationLogic {
    func presentSearchBookFailed(response: SearchModels.SearchBook.Failure.Response) {
        let localizedErrorMessage = getLocalizedMessage(from: response.error)
        display?.displaySearchBookFailed(viewModel: .init(errorMessage: localizedErrorMessage))
    }
    
    func presentSearchBookSucceed(response: SearchModels.SearchBook.Success.Response) {
        display?.displaySearchBookSucceed(viewModel: .init(books: response.books))
    }
    
    func presentSearchHistory(response: SearchModels.FetchHistory.Response) {
        display?.displaySearchHistory(viewModel: .init(terms: response.terms))
    }
}

// MARK: - PresentableError

extension SearchPresenter: PresentableError {}
