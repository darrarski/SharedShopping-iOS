import UIKit
import SnapKit
import RxSwift

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
        disposeBag = DisposeBag()
        cleanUp()
    }

    private(set) var disposeBag = DisposeBag()

    // MARK: Subviews

    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        return label
    }()

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

    // MARK: Private

    private func cleanUp() {
        titleLabel.text = nil
    }

}
