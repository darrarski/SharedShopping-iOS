import Quick
import Nimble
import RxSwift

@testable import SharedShoppingApp

class TableViewControllerSpec: QuickSpec {

    override func spec() {
        describe("TableViewController init with coder") {
            it("should throw fatal error") {
                onSimulator {
                    expect { _ = TableViewController(coder: NSCoder()) }.to(throwAssertion())
                }
            }
        }

        describe("TableViewController") {
            var sut: TableViewController!
            var inputs: Inputs!

            beforeEach {
                inputs = Inputs()
                sut = TableViewController(style: .plain, inputs: inputs)
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should have footer view") {
                    expect(sut.tableView.tableFooterView).notTo(beNil())
                }

                it("should have correct number of rows in section 0") {
                    expect(sut.tableView(sut.tableView, numberOfRowsInSection: 0))
                        .to(equal(inputs.rowViewModelsStub.value.count))
                }

                it("should have no rows in section 1") {
                    expect(sut.tableView(sut.tableView, numberOfRowsInSection: 1)).to(equal(0))
                }

                describe("row 7 in section 0") {
                    var indexPath: IndexPath!
                    var rowStub: TableRowViewModelStub!

                    beforeEach {
                        indexPath = IndexPath(row: 7, section: 0)
                        rowStub = inputs.rowViewModelsStub.value[indexPath.row]
                        rowStub.actionsStub = [
                            UITableViewRowAction(style: .default, title: "Test Action", handler: { _, _ in })
                        ]
                    }

                    it("should have correct estimated height") {
                        expect(sut.tableView(sut.tableView, estimatedHeightForRowAt: indexPath)).to(equal(rowStub.estimatedHeightStub))
                        expect(rowStub.estimatedHeightCalled).to(beTrue())
                    }

                    it("should have correct height") {
                        expect(sut.tableView(sut.tableView, heightForRowAt: indexPath)).to(equal(rowStub.heightStub))
                        expect(rowStub.heightCalled).to(beTrue())
                    }

                    it("should have correct cell") {
                        expect(sut.tableView(sut.tableView, cellForRowAt: indexPath)).to(be(rowStub.cellStub))
                        expect(rowStub.registerInTableViewCalled).to(be(sut.tableView))
                        expect(rowStub.cellAtIndexPathInTableViewCalled?.0).to(equal(indexPath))
                        expect(rowStub.cellAtIndexPathInTableViewCalled?.1).to(be(sut.tableView))
                    }

                    it("should have correct actions") {
                        expect(sut.tableView(sut.tableView, editActionsForRowAt: indexPath)).to(equal(rowStub.actionsStub))
                        expect(rowStub.actionsCalled).to(beTrue())
                    }
                }

                context("insert row") {
                    var rowViewModelStub: TableRowViewModelStub!
                    var methodCallObserver: MethodCallObserver!

                    beforeEach {
                        rowViewModelStub = TableRowViewModelStub(shopping: ShoppingFake(name: "Inserted", date: Date()))

                        methodCallObserver = MethodCallObserver()
                        methodCallObserver.observe(sut.tableView, #selector(sut.tableView.beginUpdates))
                        methodCallObserver.observe(sut.tableView, #selector(sut.tableView.endUpdates))
                        methodCallObserver.observe(sut.tableView, #selector(sut.tableView.insertRows(at:with:)))
                        methodCallObserver.observe(sut.tableView, #selector(sut.tableView.deleteRows(at:with:)))

                        var rows = inputs.rowViewModelsStub.value
                        rows.remove(at: 10)
                        rows.insert(rowViewModelStub, at: 7)
                        inputs.rowViewModelsStub.value = rows
                    }

                    it("should call table view methods in correct order") {
                        expect(methodCallObserver.observedCalls.map { $0.0.description }).to(equal([
                            #selector(sut.tableView.beginUpdates),
                            #selector(sut.tableView.insertRows(at:with:)),
                            #selector(sut.tableView.deleteRows(at:with:)),
                            #selector(sut.tableView.endUpdates)
                        ].map { $0.description }))
                    }

                    it("should pass correct params to insert rows method") {
                        let params = methodCallObserver.observedCalls[1].1
                        expect(params[0] as? [IndexPath]).to(equal([IndexPath(row: 7, section: 0)]))
                        expect(params[1] as? Int).to(equal(UITableViewRowAnimation.automatic.rawValue))
                    }

                    it("should pass correct params to delete rows method") {
                        let params = methodCallObserver.observedCalls[2].1
                        expect(params[0] as? [IndexPath]).to(equal([IndexPath(row: 10, section: 0)]))
                        expect(params[1] as? Int).to(equal(UITableViewRowAnimation.automatic.rawValue))
                    }
                }
            }
        }
    }

    private class Inputs: TableViewControllerInputs {

        let rowViewModelsStub = Variable<[TableRowViewModelStub]>((1...15).map { index in
            TableRowViewModelStub(shopping: ShoppingFake(name: "Test Shopping \(index)", date: Date()))
        })

        // MARK: TableViewControllerInputs

        var rowViewModels: Observable<[TableRowViewModel]> {
            return rowViewModelsStub.asObservable().map { $0 as [TableRowViewModel] }
        }

    }

}
