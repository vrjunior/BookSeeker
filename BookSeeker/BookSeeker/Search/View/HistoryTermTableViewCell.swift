import Cartography
import UIKit

final class HistoryTermTableViewCell: UITableViewCell {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.historySearch.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var display: String?
    
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

extension HistoryTermTableViewCell: CodeView {
    func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(separatorView)
    }
    
    func setupConstraints() {
        constrain(iconImageView, contentView) { icon, superview in
            icon.top == superview.top + Margin.normal
            icon.leading == superview.leading + Margin.normal
            icon.bottom == superview.bottom - Margin.normal
            
            icon.height == 16
            icon.width == 16
        }
        
        constrain(titleLabel, iconImageView, contentView) { title, icon, superview in
            title.leading == icon.trailing + Margin.small
            title.top == icon.top
            title.bottom == icon.bottom
            title.trailing == superview.trailing - Margin.normal
        }
        
        constrain(separatorView, titleLabel, iconImageView, contentView) { separator, title, icon, superview in
            
            separator.leading == icon.leading
            separator.trailing == title.trailing
            separator.bottom == superview.bottom
            
            separator.height == 1
        }
    }
    
    func setupExtraConfiguration() {
        contentView.backgroundColor = .white
        selectionStyle = .none
    }
}

// MARK: - Displayable

extension HistoryTermTableViewCell: Displayable {
    func configure(withDisplay display: String) {
        self.display = display
        titleLabel.text = display
    }
}
