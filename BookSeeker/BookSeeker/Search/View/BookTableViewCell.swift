import Cartography
import Kingfisher
import UIKit

final class BookTableViewCell: UITableViewCell {
    private let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    var display: SearchModels.Book?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - CodeView

extension BookTableViewCell: CodeView {
    func setupViews() {
        contentView.addSubview(artworkImageView)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        constrain(artworkImageView, contentView) { image, superview in
            image.top == superview.top + Margin.normal
            image.leading == superview.leading + Margin.normal
            image.bottom == superview.bottom - Margin.normal
            image.height == 50
            image.width == 40
        }
        
        constrain(titleLabel, artworkImageView, contentView) { title, image, superview in
            title.top == image.top
            title.leading == image.trailing + Margin.small
            title.trailing == superview.trailing - Margin.normal
            title.bottom == image.bottom
        }
    }
    
    func setupExtraConfiguration() {
        contentView.layer.cornerRadius = 4.0
        contentView.backgroundColor = .white
        setupShadow()
    }
    
    private func setupShadow() {
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 4.0
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        contentView.layer.shadowOpacity = 1.0
    }
}

extension BookTableViewCell: Displayable {
    func configure(withDisplay display: SearchModels.Book) {
        self.display = display
        let imageURL = URL(string: display.thumbArtworkUrl)
        artworkImageView.kf.setImage(with: imageURL)
        titleLabel.text = display.name
    }
}
