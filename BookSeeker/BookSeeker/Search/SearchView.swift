import UIKit

protocol SearchInputLogic where Self: UIView {
    var searchBarText: String { get }
}

protocol SearchBarViewDelegate: AnyObject {
    func didTapOnCancelSearchButton()
    func didTapOnSearchButton()
}

final class SearchView: UIView {
    
    // MARK: - Views
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: - Properties
    
    weak var delegate: SearchBarViewDelegate?
    
    var searchBarText: String {
        return searchBar.text ?? ""
    }
}

// MARK: - SearchInputLogic

extension SearchView: SearchInputLogic {
    
}

// MARK: - CodeView

extension SearchView: CodeView {
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupExtraConfiguration() {
        backgroundColor = .black
    }
}

// MARK: - UISearchBarDelegate

extension SearchView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didTapOnCancelSearchButton()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didTapOnSearchButton()
    }
}
