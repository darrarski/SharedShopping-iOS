import Quick
import Nimble
@testable import SharedShoppingApp

class ShoppingsTableCellFactorySpec: QuickSpec {

    override func spec() {
        describe("ShoppingsTableCellFactory") {
            var sut: ShoppingsTableCellFactory!

            beforeEach {
                sut = ShoppingsTableCellFactory()
            }

            context("register") {
                var tableViewSpy: UITableViewSpy!

                beforeEach {
                    tableViewSpy = UITableViewSpy()
                    sut.register(in: tableViewSpy)
                }

                it("should register correct cell") {
                    expect(tableViewSpy.registerCellClassForCellReuseIdentifierCalled?.0)
                        .to(be(ShoppingsTableCell.self))
                    expect(tableViewSpy.registerCellClassForCellReuseIdentifierCalled?.1)
                        .to(equal("shopping"))
                }

                context("get cell") {
                    var cellIdentifier: String!
                    var indexPath: IndexPath!

                    beforeEach {
                        cellIdentifier = "shopping"
                        indexPath = IndexPath(row: 5, section: 7)
                        _ = sut.cell(withId: cellIdentifier, at: indexPath, in: tableViewSpy)
                    }

                    it("should dequeue correct cell") {
                        expect(tableViewSpy.dequeueReusableCellWithIdentifierForIndexPathCalled?.0)
                            .to(equal(cellIdentifier))
                        expect(tableViewSpy.dequeueReusableCellWithIdentifierForIndexPathCalled?.1)
                            .to(equal(indexPath))
                    }
                }
            }
        }
    }

}
