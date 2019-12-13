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
