import Cartography
import UIKit

protocol BookDetailsInputLogic where Self: UIView {
    func displayBookDetails(with book: BookDetailsModels.Book)
}

final class BookDetailsView: UIView {
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - BookDetailsInputLogic

extension BookDetailsView: BookDetailsInputLogic {
    func displayBookDetails(with book: BookDetailsModels.Book) {
        let imageURL = URL(string: book.artworkUrl)
        artworkImageView.kf.setImage(with: imageURL)
        nameLabel.text = book.name
        authorLabel.text = book.author
    }
}

// MARK: - CodeView

extension BookDetailsView: CodeView {
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(artworkImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(authorLabel)
    }
    
    func setupConstraints() {
        constrain(scrollView, self) { scroll, superview in
            scroll.edges == superview.edges
        }
        
        constrain(contentView, scrollView) { content, scroll in
            content.edges == scroll.edges
            content.width == scroll.width
        }
        
        constrain(artworkImageView, contentView) { image, content in
            image.leading == content.leading
            image.trailing == content.trailing
            image.top == content.top
            image.width == 300
        }
        
        constrain(nameLabel, artworkImageView, contentView) { name, image, content in
            name.leading == content.leading + Margin.normal
            name.top == image.bottom + Margin.small
            name.trailing == image.trailing - Margin.normal
        }
        
        constrain(authorLabel, nameLabel, contentView) { author, name, content in
            author.leading == name.leading
            author.top == name.bottom + Margin.small
            author.trailing == name.trailing
            author.bottom == content.bottom - Margin.normal
        }
    }
    
    func setupExtraConfiguration() {
        backgroundColor = .white
    }
}
