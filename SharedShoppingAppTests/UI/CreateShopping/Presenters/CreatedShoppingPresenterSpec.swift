import Quick
import Nimble

@testable import SharedShoppingApp

class CreatedShoppingPresenterSpec: QuickSpec {

    override func spec() {
        describe("CreatedShoppingPresenter") {
            var sut: CreatedShoppingPresenter!
            var navigationControllerSpy: UINavigationControllerSpy!
            var shoppingViewController: UIViewController!
            var didCreateShoppingViewController: Bool!

            beforeEach {
                navigationControllerSpy = UINavigationControllerSpy()
                shoppingViewController = UIViewController()
                didCreateShoppingViewController = false
                sut = CreatedShoppingPresenter(
                    navigationController: navigationControllerSpy,
                    shoppingViewControllerFactory: { _ in
                        didCreateShoppingViewController = true
                        return shoppingViewController
                    }
                )
            }

            context("present created shopping from unreleated view controllers") {
                var firstViewController: UIViewController!
                var secondViewController: UIViewController!
                var thirdViewController: UIViewController!

                beforeEach {
                    firstViewController = UIViewController()
                    secondViewController = UIViewController()
                    thirdViewController = UIViewController()
                    navigationControllerSpy.viewControllers = [
                        firstViewController,
                        secondViewController,
                        thirdViewController
                    ]
                    sut.presentCreatedShopping(ShoppingFake(name: "Created Shopping", date: Date()))
                }

                it("should create view controller") {
                    expect(didCreateShoppingViewController).to(beTrue())
                }

                it("should update view controller") {
                    expect(navigationControllerSpy.viewControllers).toEventually(equal([
                        firstViewController,
                        secondViewController,
                        thirdViewController,
                        shoppingViewController
                    ]))
                }
            }

            context("present created shopping directly from CreateShoppingViewController") {
                var firstViewController: UIViewController!
                var secondViewController: UIViewController!
                var thirdViewController: CreateShoppingViewController!

                beforeEach {
                    firstViewController = UIViewController()
                    secondViewController = UIViewController()
                    thirdViewController = CreateShoppingViewController(
                        scrollViewController: ScrollViewController(
                            keyboardListener: KeyboardFrameChangeListenerMock(),
                            scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiderSpy()
                        ),
                        outputs: CreateShoppingViewControllerOutputsFake()
                    )
                    navigationControllerSpy.viewControllers = [
                        firstViewController,
                        secondViewController,
                        thirdViewController
                    ]
                    sut.presentCreatedShopping(ShoppingFake(name: "Created Shopping", date: Date()))
                }

                it("should create view controller") {
                    expect(didCreateShoppingViewController).to(beTrue())
                }

                it("should update view controller") {
                    expect(navigationControllerSpy.viewControllers).toEventually(equal([
                        firstViewController,
                        secondViewController,
                        shoppingViewController
                    ]))
                }
            }

            context("present created shopping indirectly from CreateShoppingViewController") {
                var firstViewController: UIViewController!
                var secondViewController: CreateShoppingViewController!
                var thirdViewController: UIViewController!

                beforeEach {
                    firstViewController = UIViewController()
                    secondViewController = CreateShoppingViewController(
                        scrollViewController: ScrollViewController(
                            keyboardListener: KeyboardFrameChangeListenerMock(),
                            scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiderSpy()
                        ),
                        outputs: CreateShoppingViewControllerOutputsFake()
                    )
                    thirdViewController = UIViewController()
                    navigationControllerSpy.viewControllers = [
                        firstViewController,
                        secondViewController,
                        thirdViewController
                    ]
                    sut.presentCreatedShopping(ShoppingFake(name: "Created Shopping", date: Date()))
                }

                it("should create view controller") {
                    expect(didCreateShoppingViewController).to(beTrue())
                }

                it("should update view controller") {
                    expect(navigationControllerSpy.viewControllers).toEventually(equal([
                        firstViewController,
                        shoppingViewController
                    ]))
                }
            }
        }
    }

    private struct CreateShoppingViewControllerOutputsFake: CreateShoppingViewControllerOutputs {

        // MARK: CreateShoppingViewControllerOutputs

        func createShopping() {}

    }

}
