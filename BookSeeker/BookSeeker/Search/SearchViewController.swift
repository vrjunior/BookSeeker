import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displaySearchBookSucceed(viewModel: SearchModels.SearchBook.Success.ViewModel)
    func displaySearchBookFailed(viewModel: SearchModels.SearchBook.Failure.ViewModel)
    func displaySearchHistory(viewModel: SearchModels.FetchHistory.ViewModel)
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
        
        interactor.fetchHistory(request: .init())
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
    
    private func handleSearchInput(_ text: String?) {
        guard let term = text, !term.isEmpty else {
            return
        }
        customView.startLoading()
        interactor.searchBook(request: .init(term: term))
    }
}

// MARK: - SearchDisplayLogic

extension SearchViewController: SearchDisplayLogic {
    func displaySearchBookSucceed(viewModel: SearchModels.SearchBook.Success.ViewModel) {
        customView.stopLoading()
        customView.display(content: .searchResults(books: viewModel.books))
    }
    
    func displaySearchBookFailed(viewModel: SearchModels.SearchBook.Failure.ViewModel) {
        
    }
    
    func displaySearchHistory(viewModel: SearchModels.FetchHistory.ViewModel) {
        customView.display(content: .searchHistory(terms: viewModel.terms))
    }
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func didSelectBook(atIndex: Int) {
    }
}


// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        handleSearchInput(searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor.fetchHistory(request: .init())
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleSearchInput(searchBar.text)
    }
}
