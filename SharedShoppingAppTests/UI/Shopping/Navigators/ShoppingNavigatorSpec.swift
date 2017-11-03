import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingNavigatorSpec: QuickSpec {

    override func spec() {
        describe("ShoppingNavigator") {
            var sut: ShoppingNavigator!
            var navigationControllerSpy: UINavigationControllerSpy!
            var viewController: UIViewController!
            var didCreateViewControllerWithShopping: Shopping?

            beforeEach {
                navigationControllerSpy = UINavigationControllerSpy()
                viewController = UIViewController()
                sut = ShoppingNavigator(
                    navigationController: navigationControllerSpy,
                    viewControllerFactory: {
                        didCreateViewControllerWithShopping = $0
                        return viewController
                    }
                )
            }

            context("navigate to Shopping") {
                var shoppingFake: ShoppingFake!

                beforeEach {
                    shoppingFake = ShoppingFake(name: "Test", date: Date())
                    sut.navigateToShopping(shoppingFake)
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
