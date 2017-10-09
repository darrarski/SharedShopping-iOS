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
            var outputs: Outputs!

            beforeEach {
                assembly = Assembly()
                inputs = Inputs()
                outputs = Outputs()
                sut = ShoppingsViewController(assembly: assembly, inputs: inputs, outputs: outputs)
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should embed tableViewController") {
                    expect(sut.childViewControllers).to(contain(assembly.tableViewController))
                }

                it("should have correct title") {
                    expect(sut.title).to(equal(inputs.title))
                }

                it("should have right bar button item in navigation item") {
                    expect(sut.navigationItem.rightBarButtonItem).notTo(beNil())
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

    private class Outputs: ShoppingsViewControllerOutputs {

    }

}
