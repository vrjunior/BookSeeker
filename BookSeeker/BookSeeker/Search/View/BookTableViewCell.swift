import Cartography
import Kingfisher
import UIKit

final class BookTableViewCell: UITableViewCell {
    private let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
        contentView.addSubview(separatorView)
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
        
        constrain(separatorView, titleLabel, artworkImageView, contentView) { separator, title, image, superview in
            
            separator.leading == image.leading
            separator.trailing == title.trailing
            separator.bottom == superview.bottom
            
            separator.height == 1
        }
    }
    
    func setupExtraConfiguration() {
        selectionStyle = .none
        contentView.backgroundColor = .white
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
