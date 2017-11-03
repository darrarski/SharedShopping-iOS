import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingPresenterSpec: QuickSpec {

    override func spec() {
        describe("ShoppingPresenter") {
            var sut: ShoppingPresenter!
            var navigationControllerSpy: UINavigationControllerSpy!
            var viewController: UIViewController!
            var didCreateViewControllerWithShopping: Shopping?

            beforeEach {
                navigationControllerSpy = UINavigationControllerSpy()
                viewController = UIViewController()
                sut = ShoppingPresenter(
                    navigationController: navigationControllerSpy,
                    viewControllerFactory: {
                        didCreateViewControllerWithShopping = $0
                        return viewController
                    }
                )
            }

            context("present Shopping") {
                var shoppingFake: ShoppingFake!

                beforeEach {
                    shoppingFake = ShoppingFake(name: "Test", date: Date())
                    sut.presentShopping(shoppingFake)
                }

                it("should create view controller with Shopping") {
                    expect(didCreateViewControllerWithShopping).to(equal(shoppingFake))
                }

                it("should push view controller") {
                    expect(navigationControllerSpy.didPushViewController?.0).to(be(viewController))
                    expect(navigationControllerSpy.didPushViewController?.1).to(beTrue())
                }
            }
        }
    }

}
