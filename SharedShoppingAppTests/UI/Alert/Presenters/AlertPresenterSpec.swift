import Quick
import Nimble

@testable import SharedShoppingApp

class AlertPresenterSpec: QuickSpec {

    override func spec() {
        describe("AlertPresenter") {
            var sut: AlertPresenter!
            var parentViewControllerSpy: ParentViewControllerSpy!
            var alertViewControllerFactorySpy: AlertViewControllerFactorySpy!

            beforeEach {
                parentViewControllerSpy = ParentViewControllerSpy()
                alertViewControllerFactorySpy = AlertViewControllerFactorySpy()
                sut = AlertPresenter(
                    parentViewController: parentViewControllerSpy,
                    alertViewControllerFactory: alertViewControllerFactorySpy
                )
            }

            context("present") {
                beforeEach {
                    sut.presentAlert(AlertViewModel(title: "", message: "", actions: []))
                }

                it("should create view controller") {
                    expect(alertViewControllerFactorySpy.createdViewController).notTo(beNil())
                }

                it("should present correct view controller") {
                    expect(parentViewControllerSpy.didPresentViewController?.0)
                        .to(be(alertViewControllerFactorySpy.createdViewController))
                }

                it("should present animated") {
                    expect(parentViewControllerSpy.didPresentViewController?.1).to(beTrue())
                }
            }
        }
    }

    private class ParentViewControllerSpy: UIViewController {

        var didPresentViewController: (UIViewController, Bool)?

        // MARK: UIViewController

        override func present(_ viewControllerToPresent: UIViewController,
                              animated flag: Bool,
                              completion: (() -> Void)? = nil) {
            didPresentViewController = (viewControllerToPresent, flag)
        }

    }

}
