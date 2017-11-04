import Quick
import Nimble

@testable import SharedShoppingApp

class CreatedShoppingPresenterSpec: QuickSpec {

    override func spec() {
        describe("CreatedShoppingPresenter") {
            var sut: CreatedShoppingPresenter!
            var navigationControllerSpy: UINavigationControllerSpy!
            var viewController: UIViewController!
            var didCreateViewController: Bool!

            beforeEach {
                navigationControllerSpy = UINavigationControllerSpy()
                viewController = UIViewController()
                didCreateViewController = false
                sut = CreatedShoppingPresenter(
                    navigationController: navigationControllerSpy,
                    viewControllerFactory: { _ in
                        didCreateViewController = true
                        return viewController
                    }
                )
            }

            context("present created shopping") {
                var firstViewController: UIViewController!
                var secondViewController: UIViewController!
                var thirdViewController: CreateShoppingViewController!

                beforeEach {
                    firstViewController = UIViewController()
                    secondViewController = UIViewController()
                    thirdViewController = CreateShoppingViewController(outputs: CreateShoppingViewControllerOutputsFake())
                    navigationControllerSpy.viewControllers = [
                        firstViewController,
                        secondViewController,
                        thirdViewController
                    ]
                    sut.presentCreatedShopping(ShoppingFake(name: "Created Shopping", date: Date()))
                }

                it("should create view controller") {
                    expect(didCreateViewController).to(beTrue())
                }

                it("should update view controller") {
                    expect(navigationControllerSpy.viewControllers).toEventually(equal([
                        firstViewController,
                        secondViewController,
                        viewController
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
