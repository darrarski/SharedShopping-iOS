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
                var row: TableRowStub!
                var indexPath: IndexPath!

                beforeEach {
                    row = inputs.rowStub
                    indexPath = IndexPath(row: 7, section: 11)
                }

                it("should have correct estimated height") {
                    expect(sut.tableView(sut.tableView, estimatedHeightForRowAt: indexPath)).to(equal(row.estimatedHeightStub))
                    expect(row.estimatedHeightAtIndexPathCalled).to(equal(indexPath))
                }

                it("should have correct height") {
                    expect(sut.tableView(sut.tableView, heightForRowAt: indexPath)).to(equal(row.heightStub))
                    expect(row.heightAtIndexPathCalled).to(equal(indexPath))
                }

                it("should have correct cell") {
                    expect(sut.tableView(sut.tableView, cellForRowAt: indexPath)).to(be(row.cellStub))
                    expect(row.cellAtIndexPathInTableViewCalled?.0).to(equal(indexPath))
                    expect(row.cellAtIndexPathInTableViewCalled?.1).to(be(sut.tableView))
                    expect(row.registerInTableViewCalled).to(be(sut.tableView))
                }
            }
        }
    }

    private class Inputs: TableViewControllerInputs {

        var numberOfRowsStub: Int = 15
        var rowStub = TableRowStub()

        var numberOfRowsInSectionCalled: Int?
        var rowAtIndexPathCalled: IndexPath?

        // MARK: TableViewControllerInputs

        func numberOfRows(in section: Int) -> Int {
            numberOfRowsInSectionCalled = section
            return numberOfRowsStub
        }

        func row(at indexPath: IndexPath) -> TableRow {
            rowAtIndexPathCalled = indexPath
            return rowStub
        }

    }

}
