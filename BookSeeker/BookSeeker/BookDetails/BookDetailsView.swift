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
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
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
    
    private func getDescriptionAttributedString(from description: String) -> NSAttributedString? {
        guard let data = description.data(using: .unicode, allowLossyConversion: true) else {
            return nil
        }
        let attributed = try? NSAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
        
        return attributed
    }
}

// MARK: - BookDetailsInputLogic

extension BookDetailsView: BookDetailsInputLogic {
    func displayBookDetails(with book: BookDetailsModels.Book) {
        let imageURL = URL(string: book.artworkUrl)
        artworkImageView.kf.setImage(with: imageURL)
        nameLabel.text = book.name
        authorLabel.text = book.author
        descriptionLabel.attributedText = getDescriptionAttributedString(from: book.descriptionHtmlText)
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
        contentView.addSubview(descriptionLabel)
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
            image.height == 200
        }
        
        constrain(nameLabel, artworkImageView, contentView) { name, image, content in
            name.leading == content.leading + Margin.normal
            name.top == image.bottom + Margin.small
            name.trailing == image.trailing - Margin.normal
        }
        
        constrain(authorLabel, nameLabel) { author, name in
            author.leading == name.leading
            author.top == name.bottom + Margin.small
            author.trailing == name.trailing
        }
        
        constrain(descriptionLabel, authorLabel, contentView) { description, author, content in
            description.top == author.bottom + Margin.big
            description.leading == author.leading
            description.trailing == author.trailing
            description.bottom == content.bottom - Margin.normal
        }
    }
    
    func setupExtraConfiguration() {
        backgroundColor = .white
    }
}
