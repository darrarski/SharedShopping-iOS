import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingsTableViewModelSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsTableViewModel") {
            var sut: ShoppingsTableViewModel!
            var assembly: Assembly!

            beforeEach {
                assembly = Assembly()
                sut = ShoppingsTableViewModel(assembly: assembly)
            }

            it("should have four rows in first section") {
                expect(sut.numberOfRows(in: 0)).to(equal(4))
            }

            it("should throw when asked for number of rows in second section") {
                expect { _ = sut.numberOfRows(in: 1) }.to(throwAssertion())
            }

            describe("row view model at row 0 in section 0") {
                var rowViewModel: TableRowViewModel!

                beforeEach {
                    rowViewModel = sut.rowViewModel(at: IndexPath(row: 0, section: 0))
                }

                it("should call assembly") {
                    expect(assembly.tableRowViewModelShoppingCalled).notTo(beNil())
                }

                it("should be correct") {
                    expect(rowViewModel).to(be(assembly.tableRowViewModelStub))
                }
            }

            it("should throw when asked for row view model at row 0 in section 1") {
                expect { _ = sut.rowViewModel(at: IndexPath(row: 0, section: 1)) }.to(throwAssertion())
            }
        }
    }

    private class Assembly: ShoppingsTableViewModelAssembly {

        var tableRowViewModelStub = TableRowViewModelStub()

        var tableRowViewModelShoppingCalled: (Shopping)?

        // MARK: ShoppingsTableViewModelAssembly

        func tableRowViewModel(shopping: Shopping) -> TableRowViewModel {
            tableRowViewModelShoppingCalled = (shopping)
            return tableRowViewModelStub
        }

    }

}
