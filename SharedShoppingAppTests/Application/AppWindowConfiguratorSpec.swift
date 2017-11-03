import Quick
import Nimble

@testable import SharedShoppingApp

class AppWindowConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("AppWindowConfigurator") {
            var sut: AppWindowConfigurator!
            var navigationController: UINavigationController!
            var viewController: UIViewController!

            beforeEach {
                navigationController = UINavigationController()
                viewController = UIViewController(nibName: nil, bundle: nil)
                sut = AppWindowConfigurator(
                    navigationController: { navigationController },
                    rootViewController: { viewController }
                )
            }

            context("configure window") {
                var windowSpy: UIWindowSpy!

                beforeEach {
                    windowSpy = UIWindowSpy()
                    sut.configureWindow(windowSpy)
                }

                it("should window have correct root view controller") {
                    expect(windowSpy.rootViewController).to(be(navigationController))
                }

                it("should navigation controlller have correct view controllers") {
                    expect(navigationController.viewControllers).to(be([viewController]))
                }

                it("should make window key and visible") {
                    expect(windowSpy.makeKeyAndVisibleCalled).to(beTrue())
                }
            }
        }
    }

}
