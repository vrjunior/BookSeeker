import UIKit

protocol SearchConfiguratorProtocol {
    func createScene() -> SearchDisplayLogic & UIViewController
}

final class SearchConfigurator: SearchConfiguratorProtocol {
    func createScene() -> SearchDisplayLogic & UIViewController {
        let presenter = SearchPresenter()
        let historyWorker = SearchHistoryWorker()
        let searchWorker = SearchWorker()
        let interactor = SearchInteractor(
            presenter: presenter,
            historyWorker: historyWorker,
            searchWorker: searchWorker
        )
        let view = SearchView()
        let router = SearchRouter(dataStore: interactor)
        let viewController = SearchViewController(customView: view, interactor: interactor, router: router)
        router.viewController = viewController
        presenter.display = viewController
        
        return viewController
    }
}
