import Quick
import Nimble
@testable import SharedShoppingApp

class TableViewRowActionFactorySpec: QuickSpec {

    override func spec() {
        describe("TableViewRowActionFactory") {
            var sut: TableViewRowActionFactory!

            beforeEach {
                sut = TableViewRowActionFactory { UITableViewRowActionSpy.create(style: $0, title: $1, handler: $2) }
            }

            describe("delete action") {
                var title: String!
                var action: TableRowAction!
                var tableViewRowAction: UITableViewRowAction!
                var didDelete: Bool!

                beforeEach {
                    title = "DELETE"
                    didDelete = false
                    action = TableRowAction.delete(title: title, handler: { didDelete = true })
                    tableViewRowAction = sut.tableViewRowAction(for: action)
                }

                it("should have correct title") {
                    expect(tableViewRowAction.title).to(equal(title))
                }

                context("perform") {
                    beforeEach {
                        (tableViewRowAction as! UITableViewRowActionSpy).handler(tableViewRowAction, IndexPath(row: 5, section: 9))
                    }

                    it("should delete") {
                        expect(didDelete).to(beTrue())
                    }
                }
            }
        }
    }

}
