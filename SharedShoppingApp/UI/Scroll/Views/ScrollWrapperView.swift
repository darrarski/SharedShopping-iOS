import UIKit
import SnapKit

class ScrollWrapperView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
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

    func updateVisibleContentLayoutGuide(insets: UIEdgeInsets) {
        visibleContentLayoutGuide.snp.updateConstraints {
            $0.edges.equalTo(insets)
        }
    }

    private let visibleContentLayoutGuide = UILayoutGuide()

    private func setupLayout() {
        addLayoutGuide(visibleContentLayoutGuide)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        visibleContentLayoutGuide.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(visibleContentLayoutGuide.snp.height)
        }
        updateVisibleContentLayoutGuide(insets: scrollView.adjustedContentInset)
    }

    private func setupLayout(contentView: UIView) {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

private extension ScrollWrapperView {
    struct Factory {
        static var scrollView: UIScrollView {
            let view = UIScrollView(frame: .zero)
            view.keyboardDismissMode = .interactive
            return view
        }
    }
}
