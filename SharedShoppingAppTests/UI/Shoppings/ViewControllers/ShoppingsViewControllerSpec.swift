import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingsViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsViewController init with coder") {
            it("should throw fatal error") {
                expect { _ = ShoppingsViewController(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        describe("ShoppingsViewController") {
            var sut: ShoppingsViewController!
            var assembly: Assembly!

            beforeEach {
                assembly = Assembly()
                sut = ShoppingsViewController(assembly: assembly)
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should embed tableViewController") {
                    expect(sut.childViewControllers).to(contain(assembly.tableViewController))
                }
            }
        }
    }

    private class Assembly: ShoppingsViewControllerAssembly {

        let tableViewController = UIViewController(nibName: nil, bundle: nil)

    }

}