import UIKit
import SnapKit

class CreateShoppingView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: Subviews

    let textView: UITextView = {
        let view = UITextView(frame: .zero)
        view.backgroundColor = .white
        view.isScrollEnabled = false
        view.font = UIFont.preferredFont(forTextStyle: .body)
        return view
    }()

    private func addSubviews() {
        addSubview(textView)
    }

    // MARK: Layout

    private func setupLayout() {
        textView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
    }

}
