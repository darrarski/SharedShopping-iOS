import UIKit
import SnapKit

class ShoppingsTableCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        loadSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: Subviews

    let titleLabel = Factory.titleLabel
    let subtitleLabel = Factory.subtitleLabel

    private func loadSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }

    // MARK: Layout

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
            $0.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }

}

private extension ShoppingsTableCell {
    struct Factory {
        static var titleLabel: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
            return label
        }

        static var subtitleLabel: UILabel {
            let label = UILabel(frame: .zero)
            label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
            return label
        }
    }
}
