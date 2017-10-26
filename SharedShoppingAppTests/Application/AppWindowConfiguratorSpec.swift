import Quick
import Nimble

@testable import SharedShoppingApp

class AppWindowConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("AppWindowConfigurator") {
            var sut: AppWindowConfigurator!
            var viewController: UIViewController!

            beforeEach {
                viewController = UIViewController(nibName: nil, bundle: nil)
                sut = AppWindowConfigurator(rootViewController: { viewController })
            }

            context("configure window") {
                var windowSpy: UIWindowSpy!

                beforeEach {
                    windowSpy = UIWindowSpy()
                    sut.configureWindow(windowSpy)
                }

                it("should window have root navigation controller") {
                    expect(windowSpy.rootViewController).to(beAKindOf(UINavigationController.self))
                }

                it("should window root navigation controller have correct root") {
                    expect((windowSpy.rootViewController as? UINavigationController)?.viewControllers.first)
                        .to(be(viewController))
                }

                it("should make window key and visible") {
                    expect(windowSpy.makeKeyAndVisibleCalled).to(beTrue())
                }
            }
        }
    }

}
