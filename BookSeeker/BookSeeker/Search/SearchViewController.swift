import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displaySearchBookSucceed(viewModel: SearchModels.SearchBook.Success.ViewModel)
    func displaySearchBookFailed(viewModel: SearchModels.SearchBook.Failure.ViewModel)
}

final class SearchViewController: UIViewController {
    
    private let customView: SearchInputLogic
    private let interactor: SearchBusinessLogic
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
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
        setupSearchBar()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        view = customView
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - SearchDisplayLogic

extension SearchViewController: SearchDisplayLogic {
    func displaySearchBookSucceed(viewModel: SearchModels.SearchBook.Success.ViewModel) {
        customView.booksToDisplay = viewModel.books
    }
    
    func displaySearchBookFailed(viewModel: SearchModels.SearchBook.Failure.ViewModel) {
        
    }
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func didSelectBook(atIndex: Int) {
    }
}


// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text, !term.isEmpty else {
            return
        }
        interactor.searchBook(request: .init(term: term))
    }
}
