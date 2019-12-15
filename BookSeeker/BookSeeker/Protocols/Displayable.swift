protocol Displayable {
    associatedtype DisplayType

    var display: DisplayType? { get }

    func configure(withDisplay display: DisplayType)
}
