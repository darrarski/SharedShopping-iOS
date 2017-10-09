import Quick
import Nimble

@testable import SharedShoppingApp

class TableViewControllerSpec: QuickSpec {

    override func spec() {
        describe("TableViewController init with coder") {
            it("should throw fatal error") {
                expect { _ = TableViewController(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        describe("TableViewController") {
            var sut: TableViewController!
            var inputs: Inputs!

            beforeEach {
                inputs = Inputs()
                sut = TableViewController(style: .plain, inputs: inputs)
            }

            it("should have correct number of rows in section 5") {
                expect(sut.tableView(sut.tableView, numberOfRowsInSection: 5)).to(equal(inputs.numberOfRowsStub))
                expect(inputs.numberOfRowsInSectionCalled).to(equal(5))
            }

            describe("row 7 in section 11") {
                var row: TableRowViewModelStub!
                var indexPath: IndexPath!

                beforeEach {
                    row = inputs.rowStub
                    inputs.rowStub.actionsStub = [
                        UITableViewRowAction(style: .default, title: "Test Action", handler: { _, _ in })
                    ]
                    indexPath = IndexPath(row: 7, section: 11)
                }

                it("should have correct estimated height") {
                    expect(sut.tableView(sut.tableView, estimatedHeightForRowAt: indexPath)).to(equal(row.estimatedHeightStub))
                    expect(row.estimatedHeightCalled).to(beTrue())
                }

                it("should have correct height") {
                    expect(sut.tableView(sut.tableView, heightForRowAt: indexPath)).to(equal(row.heightStub))
                    expect(row.heightCalled).to(beTrue())
                }

                it("should have correct cell") {
                    expect(sut.tableView(sut.tableView, cellForRowAt: indexPath)).to(be(row.cellStub))
                    expect(inputs.rowViewModelAtIndexPathCalled).to(equal(indexPath))
                    expect(row.registerInTableViewCalled).to(be(sut.tableView))
                    expect(row.cellAtIndexPathInTableViewCalled?.0).to(equal(indexPath))
                    expect(row.cellAtIndexPathInTableViewCalled?.1).to(be(sut.tableView))
                }

                it("should have correct actions") {
                    expect(sut.tableView(sut.tableView, editActionsForRowAt: indexPath)).to(equal(inputs.rowStub.actionsStub))
                    expect(inputs.rowStub.actionsCalled).to(beTrue())
                }
            }
        }
    }

    private class Inputs: TableViewControllerInputs {

        var numberOfRowsStub: Int = 15
        var rowStub = TableRowViewModelStub()

        var numberOfRowsInSectionCalled: Int?
        var rowViewModelAtIndexPathCalled: IndexPath?

        // MARK: TableViewControllerInputs

        func numberOfRows(in section: Int) -> Int {
            numberOfRowsInSectionCalled = section
            return numberOfRowsStub
        }

        func rowViewModel(at indexPath: IndexPath) -> TableRowViewModel {
            rowViewModelAtIndexPathCalled = indexPath
            return rowStub
        }

    }

}
