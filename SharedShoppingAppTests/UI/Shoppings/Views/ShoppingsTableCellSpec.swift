import Quick
import Nimble
@testable import SharedShoppingApp

class ShoppingsTableCellSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsTableCell") {
            var sut: ShoppingsTableCell!

            context("init with coder") {
                beforeEach {
                    sut = ShoppingsTableCell(coder: NSCoder())
                }

                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }

            context("init") {
                beforeEach {
                    sut = ShoppingsTableCell(style: .default, reuseIdentifier: "shopping")
                }

                it("should have disclosure indicator") {
                    expect(sut.accessoryType).to(equal(UITableViewCellAccessoryType.disclosureIndicator))
                }
            }
        }
    }

}
