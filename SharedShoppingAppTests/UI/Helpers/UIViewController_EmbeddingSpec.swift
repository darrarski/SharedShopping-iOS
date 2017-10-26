import Quick
import Nimble

@testable import SharedShoppingApp

class UIViewController_EmbeddingSpec: QuickSpec {

    override func spec() {
        describe("UIViewController") {
            var sut: UIViewController!

            beforeEach {
                sut = UIViewController(nibName: nil, bundle: nil)
            }

            context("embed") {
                var child: UIViewController!

                beforeEach {
                    child = UIViewController(nibName: nil, bundle: nil)
                    sut.embed(child, in: sut.view)
                }

                it("should have child view controller") {
                    expect(sut.childViewControllers).to(contain(child))
                }

                context("unembed") {
                    beforeEach {
                        sut.unembed(child)
                    }

                    it("should not have child view controller") {
                        expect(sut.childViewControllers).notTo(contain(child))
                    }
                }
            }
        }
    }

}
