import UIKit
import SnapKit

class CreateShoppingView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Subviews

    let textView: UITextView = {
        let view = UITextView(frame: .zero)
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        return view
    }()

    private func addSubviews() {
        addSubview(textView)
    }

    // MARK: Layout

    private func setupLayout() {
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
