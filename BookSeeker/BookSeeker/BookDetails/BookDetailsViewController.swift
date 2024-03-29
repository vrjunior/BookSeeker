import UIKit

final class BookDetailsViewController: UIViewController {
    
    private let customView: BookDetailsInputLogic
    private let book: BookDetailsModels.Book
    
    init(
        with book: BookDetailsModels.Book,
        view: BookDetailsInputLogic
    ) {
        self.book = book
        self.customView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.displayBookDetails(with: book)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
