import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displaySearchBookSucceed(viewModel: SearchModels.SearchBook.Success.ViewModel)
    func displaySearchBookFailed(viewModel: SearchModels.SearchBook.Failure.ViewModel)
    func displaySearchHistory(viewModel: SearchModels.FetchHistory.ViewModel)
}

final class SearchViewController: UIViewController {
    
    private let customView: SearchInputLogic
    private let interactor: SearchBusinessLogic
    private let router: SearchRoutingLogic
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = Localization.SearchViewController.SearchBar.placeholder
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    init(
        customView: SearchInputLogic,
        interactor: SearchBusinessLogic,
        router: SearchRoutingLogic
    ) {
        self.customView = customView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        customView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Localization.SearchViewController.NavigationItem.title
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
        print(viewModel.errorMessage)
    }
    
    func displaySearchHistory(viewModel: SearchModels.FetchHistory.ViewModel) {
        customView.display(content: .searchHistory(terms: viewModel.terms))
    }
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func didSelectBook(atIndex index: Int) {
        router.routeToBookDetails(with: index)
    }
    
    func didSelectHistoryTerm(term: String) {
        searchController.searchBar.text = term
        interactor.searchBook(request: .init(term: term))
    }
}


// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor.fetchHistory(request: .init())
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleSearchInput(searchBar.text)
    }
}
