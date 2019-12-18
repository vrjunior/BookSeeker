import UIKit

protocol BookDetailsConfiguratorProtocol {
    func createScene(with book: BookDetailsModels.Book) -> UIViewController
}

final class BookDetailsConfigurator: BookDetailsConfiguratorProtocol {
    func createScene(with book: BookDetailsModels.Book) ->  UIViewController {
        let view = BookDetailsView()
        let viewController = BookDetailsViewController(with: book, view: view)
        return viewController
    }
}
