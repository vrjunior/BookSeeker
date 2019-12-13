import UIKit

protocol SearchDisplayLogic: AnyObject {
    
}

final class SearchViewController: UIViewController {
    
    private let customView: SearchInputLogic
    private let interactor: SearchBusinessLogic
    
    init(
        customView: SearchInputLogic,
        interactor: SearchBusinessLogic
    ) {
        self.customView = customView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        customView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Busca"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        view = customView
    }
}

// MARK: - SearchDisplayLogic

extension SearchViewController: SearchDisplayLogic {
    
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    
    func didTapOnCancelSearchButton() {
        customView.setCancelButton(isVisible: false)
        customView.endEditing(true)
    }
    
    func didTapOnSearchButton() {
        customView.setCancelButton(isVisible: false)
        customView.endEditing(true)
    }

    func didBeginEditingSearchBar() {
        customView.setCancelButton(isVisible: true)
    }
}
