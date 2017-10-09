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
            var inputs: Inputs!

            beforeEach {
                assembly = Assembly()
                inputs = Inputs()
                sut = ShoppingsViewController(assembly: assembly, inputs: inputs)
            }

            it("should have correct title") {
                expect(sut.title).to(equal(inputs.title))
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should have right bar button item in navigation item") {
                    expect(sut.navigationItem.rightBarButtonItem).notTo(beNil())
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

    private class Inputs: ShoppingsViewControllerInputs {

        let title = "Test Title"

    }

}
