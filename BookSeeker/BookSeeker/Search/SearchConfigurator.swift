import UIKit

protocol SearchConfiguratorProtocol {
    func createScene() -> SearchDisplayLogic & UIViewController
}

final class SearchConfigurator: SearchConfiguratorProtocol {
    func createScene() -> SearchDisplayLogic & UIViewController {
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(presenter: presenter)
        let view = SearchView()
        let viewController = SearchViewController(customView: view, interactor: interactor)
        presenter.display = viewController
        
        return viewController
    }
}
