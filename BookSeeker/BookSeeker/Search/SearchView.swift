import Cartography
import UIKit

protocol SearchInputLogic where Self: UIView {
    var searchBarText: String { get }
    var delegate: SearchViewDelegate? { get set }
    
    func setCancelButton(isVisible: Bool)
}

protocol SearchViewDelegate: AnyObject {
    func didTapOnCancelSearchButton()
    func didTapOnSearchButton()
    func didBeginEditingSearchBar()
}

final class SearchView: UIView {
    
    // MARK: - Views
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.barStyle = .default
        return searchBar
    }()
    
    // MARK: - Properties
    
    weak var delegate: SearchViewDelegate?
    
    var searchBarText: String {
        return searchBar.text ?? ""
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - SearchInputLogic

extension SearchView: SearchInputLogic {
    func setCancelButton(isVisible: Bool) {
        searchBar.setShowsCancelButton(isVisible, animated: true)
    }
}

// MARK: - CodeView

extension SearchView: CodeView {
    func setupViews() {
        addSubview(searchBar)
    }
    
    func setupConstraints() {
        constrain(searchBar, self) { searchBar, superview in
            searchBar.top == superview.top + Margin.none
            searchBar.leading == superview.leading + Margin.none
            searchBar.trailing == superview.trailing - Margin.none
        }
    }
    
    func setupExtraConfiguration() {
        backgroundColor = .white
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

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.didBeginEditingSearchBar()
    }
}
