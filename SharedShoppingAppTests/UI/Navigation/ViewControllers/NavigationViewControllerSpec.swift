import Quick
import Nimble
import RxSwift

@testable import SharedShoppingApp

class NavigationViewControllerSpec: QuickSpec {

    override func spec() {
        describe("NavigationViewController") {
            var sut: NavigationViewController!
            var navigationControllerSpy: UINavigationControllerSpy!
            var inputs: Inputs!

            beforeEach {
                navigationControllerSpy = UINavigationControllerSpy()
                inputs = Inputs()
                sut = NavigationViewController(
                    navigationController: navigationControllerSpy,
                    inputs: inputs
                )
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should embed navigation controller") {
                    expect(sut.childViewControllers).to(contain(navigationControllerSpy))
                }
            }

            context("push") {
                var viewController: UIViewController!

                beforeEach {
                    viewController = UIViewController()
                    inputs.pushSubject.onNext(viewController)
                }

                it("should push") {
                    expect(navigationControllerSpy.didPushViewController).to(be(viewController))
                }
            }
        }
    }

    private class Inputs: NavigationViewControllerInputs {

        let pushSubject = PublishSubject<UIViewController>()

        // MARK: NavigationViewControllerInputs

        var root: UIViewController {
            return UIViewController()
        }

        var push: Observable<UIViewController> {
            return pushSubject.asObservable()
        }

    }

    private class UINavigationControllerSpy: UINavigationController {

        var didPushViewController: UIViewController?

        // MARK: UINavigationController

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            didPushViewController = viewController
        }

    }

}
