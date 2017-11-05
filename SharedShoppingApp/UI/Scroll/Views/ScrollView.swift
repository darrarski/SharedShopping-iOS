import UIKit
import SnapKit

class ScrollView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Subviews

    let scrollView = Factory.scrollView

    var contentView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            guard let newValue = contentView else { return }
            containerView.addSubview(newValue)
            setupLayout(contentView: newValue)
        }
    }

    private let containerView = UIView(frame: .zero)

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
    }

    // MARK: Layout

    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
    }

    private func setupLayout(contentView: UIView) {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

private extension ScrollView {
    struct Factory {
        static var scrollView: UIScrollView {
            let view = UIScrollView(frame: .zero)
            view.keyboardDismissMode = .interactive
            return view
        }
    }
}