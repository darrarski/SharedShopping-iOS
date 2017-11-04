import Quick
import Nimble

@testable import SharedShoppingApp

class CreateShoppingPresenterSpec: QuickSpec {

    override func spec() {
        describe("CreateShoppingPresenter") {
            var sut: CreateShoppingPresenter!
            var navigationControllerSpy: UINavigationControllerSpy!
            var viewController: UIViewController!
            var didCreateViewController: Bool!

            beforeEach {
                navigationControllerSpy = UINavigationControllerSpy()
                viewController = UIViewController()
                didCreateViewController = false
                sut = CreateShoppingPresenter(
                    navigationController: navigationControllerSpy,
                    viewControllerFactory: {
                        didCreateViewController = true
                        return viewController
                    }
                )
            }

            context("present Create Shopping") {
                beforeEach {
                    sut.presentCreateShopping()
                }

                it("should create view controller") {
                    expect(didCreateViewController).to(beTrue())
                }

                it("should push view controller") {
                    expect(navigationControllerSpy.didPushViewController?.0).to(be(viewController))
                    expect(navigationControllerSpy.didPushViewController?.1).to(beTrue())
                }
            }
        }
    }

}
