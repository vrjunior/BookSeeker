protocol CodeView {
    func setup()
    func setupViews()
    func setupConstraints()
    func setupExtraConfiguration()
}

extension CodeView {
    func setup() {
        setupViews()
        setupConstraints()
        setupExtraConfiguration()
    }
}
