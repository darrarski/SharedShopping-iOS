import UIKit

class ShoppingsTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadSubviews()
        setupLayout()
        cleanUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cleanUp()
    }

    // MARK: Subviews

    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        return label
    }()

    private func loadSubviews() {
        contentView.addSubview(nameLabel)
    }

    // MARK: Layout

    private func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16).isActive = true
        nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16).isActive = true
    }

    // MARK: Private

    private func cleanUp() {
        nameLabel.text = nil
    }

}
