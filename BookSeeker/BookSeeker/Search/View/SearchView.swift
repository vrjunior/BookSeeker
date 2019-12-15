import Cartography
import UIKit

protocol SearchInputLogic where Self: UIView {
    var booksToDisplay: [SearchModels.Book] { get set }
    var delegate: SearchViewDelegate? { get set }
    
    func startLoading()
    func stopLoading()
}

protocol SearchViewDelegate: AnyObject {
    func didSelectBook(atIndex: Int)
}

final class SearchView: UIView {
    
    // MARK: - Views
    
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
    
    var booksToDisplay: [SearchModels.Book] = [] {
        didSet {
            tableView.reloadData()
        }
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
        return booksToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookTableViewCell.self), for: indexPath)
        guard let bookCell = cell as? BookTableViewCell else {
            return cell
        }
        
        bookCell.configure(withDisplay: booksToDisplay[indexPath.row])
        
        return bookCell
    }
}


