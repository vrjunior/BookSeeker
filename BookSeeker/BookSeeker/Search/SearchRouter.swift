import UIKit
protocol SearchRoutingLogic {
    func routeToBookDetails(with index: Int)
}

final class SearchRouter {
    weak var viewController: UIViewController?
    private let dataStore: SearchDataStore
    
    init(dataStore: SearchDataStore) {
        self.dataStore = dataStore
    }
}

// MARK: - SearchRoutingLogic

extension SearchRouter: SearchRoutingLogic {
    func routeToBookDetails(with index: Int) {
        let book = BookDetailsModels.Book(with: dataStore.books[index])
        let bookDetailsViewController = BookDetailsConfigurator().createScene(with: book)
        viewController?.navigationController?.pushViewController(bookDetailsViewController, animated: true)
    }
}
