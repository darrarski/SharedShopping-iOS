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
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
            $0.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }

    // MARK: Private

    private func cleanUp() {
        nameLabel.text = nil
    }

}
