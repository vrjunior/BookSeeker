protocol SearchBusinessLogic {
    
}

final class SearchInteractor {
    private let presenter: SearchPresentationLogic
    
    init(presenter: SearchPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - SearchBusinessLogic

extension SearchInteractor: SearchBusinessLogic {
    
}
