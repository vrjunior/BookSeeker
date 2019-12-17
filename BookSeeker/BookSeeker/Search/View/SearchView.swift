import Cartography
import UIKit

protocol SearchInputLogic where Self: UIView {
    var delegate: SearchViewDelegate? { get set }
    
    func startLoading()
    func stopLoading()
    func display(content: SearchView.DisplayContent)
}

protocol SearchViewDelegate: AnyObject {
    func didSelectBook(atIndex: Int)
}

final class SearchView: UIView {
    
    // MARK: - Views
    
    enum DisplayContent {
        case searchResults(books: [SearchModels.Book])
        case searchHistory(terms: [String])
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 82
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .black
        return activityIndicator
    }()
    
    // MARK: - Properties
    
    weak var delegate: SearchViewDelegate?
    
    private var displayContent: SearchView.DisplayContent = .searchHistory(terms: [])
    
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
    func startLoading() {
        tableView.isHidden = true
        addSubview(loadingIndicator)
        constrain(loadingIndicator, self) { loading, superview in
            loading.centerX == superview.centerX
            loading.centerY == superview.centerY
        }
        
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        tableView.isHidden = false
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
    
    func display(content: SearchView.DisplayContent) {
        displayContent = content
        tableView.reloadData()
    }
}

// MARK: - CodeView

extension SearchView: CodeView {
    func setupViews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        constrain(tableView, self) { tableView, superview in
            tableView.edges == superview.edges
        }
    }
    
    func setupExtraConfiguration() {
        backgroundColor = .white
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: String(describing: BookTableViewCell.self))
    }
}

// MARK: - UITableViewDelegate

extension SearchView: UITableViewDelegate {
}

// MARK: - UITableViewDataSource
extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch displayContent {
        case let .searchHistory(terms):
            return terms.count
        case let .searchResults(books):
            return books.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch displayContent {
        case let .searchHistory(terms):
            let term = terms[indexPath.row]
            return cellForSearchHistory(with: term, tableView: tableView, indexPath: indexPath)
        case let .searchResults(books):
            let book = books[indexPath.row]
            return cellForSearchResult(with: book, tableView: tableView, indexPath: indexPath)
        }
        
    }
    
    private func cellForSearchHistory(with term: String, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
       return UITableViewCell()
    }
    
    private func cellForSearchResult(with book: SearchModels.Book, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookTableViewCell.self), for: indexPath)
        guard let bookCell = cell as? BookTableViewCell else {
            return cell
        }
        
        bookCell.configure(withDisplay: book)
        
        return bookCell
    
    }
}


