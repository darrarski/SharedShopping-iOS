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

            it("should have correct number of rows in section 5") {
                expect(sut.tableView(sut.tableView, numberOfRowsInSection: 5)).to(equal(inputs.numberOfRowsStub))
                expect(inputs.numberOfRowsInSectionCalled).to(equal(5))
            }

            describe("row 7 in section 11") {
                var indexPath: IndexPath!

                beforeEach {
                    inputs.rowStub.actionsStub = [
                        UITableViewRowAction(style: .default, title: "Test Action", handler: { _, _ in })
                    ]
                    indexPath = IndexPath(row: 7, section: 11)
                }

                it("should have correct estimated height") {
                    expect(sut.tableView(sut.tableView, estimatedHeightForRowAt: indexPath)).to(equal(inputs.rowStub.estimatedHeightStub))
                    expect(inputs.rowStub.estimatedHeightCalled).to(beTrue())
                }

                it("should have correct height") {
                    expect(sut.tableView(sut.tableView, heightForRowAt: indexPath)).to(equal(inputs.rowStub.heightStub))
                    expect(inputs.rowStub.heightCalled).to(beTrue())
                }

                it("should have correct cell") {
                    expect(sut.tableView(sut.tableView, cellForRowAt: indexPath)).to(be(inputs.rowStub.cellStub))
                    expect(inputs.rowViewModelAtIndexPathCalled).to(equal(indexPath))
                    expect(inputs.rowStub.registerInTableViewCalled).to(be(sut.tableView))
                    expect(inputs.rowStub.cellAtIndexPathInTableViewCalled?.0).to(equal(indexPath))
                    expect(inputs.rowStub.cellAtIndexPathInTableViewCalled?.1).to(be(sut.tableView))
                }

                it("should have correct actions") {
                    expect(sut.tableView(sut.tableView, editActionsForRowAt: indexPath)).to(equal(inputs.rowStub.actionsStub))
                    expect(inputs.rowStub.actionsCalled).to(beTrue())
                }
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should have footer view") {
                    expect(sut.tableView.tableFooterView).notTo(beNil())
                }

                context("on reload event") {
                    var reloadDataCallObserver: MethodCallObserver!

                    beforeEach {
                        reloadDataCallObserver = MethodCallObserver()
                        reloadDataCallObserver.observe(sut.tableView, #selector(sut.tableView.reloadData))

                        inputs.eventSubject.onNext(.reload)
                    }

                    it("should call reloadData on table view") {
                        expect(reloadDataCallObserver.observedCalls).to(haveCount(1))
                    }
                }

                context("on update event") {
                    var methodCallObserver: MethodCallObserver!

                    beforeEach {
                        methodCallObserver = MethodCallObserver()
                        methodCallObserver.observe(sut.tableView, #selector(sut.tableView.beginUpdates))
                        methodCallObserver.observe(sut.tableView, #selector(sut.tableView.endUpdates))
                        methodCallObserver.observe(sut.tableView, #selector(sut.tableView.insertRows(at:with:)))
                        methodCallObserver.observe(sut.tableView, #selector(sut.tableView.deleteRows(at:with:)))

                        inputs.eventSubject.onNext(.update([
                            .delete(row: 10, inSection: 0),
                            .insert(row: 7, inSection: 0)
                        ]))
                    }

                    it("should call table view methods in correct order") {
                        expect(methodCallObserver.observedCalls.map { $0.0.description }).to(equal([
                            #selector(sut.tableView.beginUpdates),
                            #selector(sut.tableView.deleteRows(at:with:)),
                            #selector(sut.tableView.insertRows(at:with:)),
                            #selector(sut.tableView.endUpdates)
                        ].map { $0.description }))
                    }

                    it("should pass correct params to delete rows method") {
                        let params = methodCallObserver.observedCalls[1].1
                        expect(params[0] as? [IndexPath]).to(equal([IndexPath(row: 10, section: 0)]))
                        expect(params[1] as? Int).to(equal(UITableViewRowAnimation.automatic.rawValue))
                    }

                    it("should pass correct params to insert rows method") {
                        let params = methodCallObserver.observedCalls[2].1
                        expect(params[0] as? [IndexPath]).to(equal([IndexPath(row: 7, section: 0)]))
                        expect(params[1] as? Int).to(equal(UITableViewRowAnimation.automatic.rawValue))
                    }
                }
            }
        }
    }

    private class Inputs: TableViewControllerInputs {

        var numberOfRowsStub: Int = 15
        var rowStub = TableRowViewModelStub(shopping: Shopping(name: "Tesy", date: Date()))
        let eventSubject = PublishSubject<TableViewController.Event>()

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

        var event: Observable<TableViewController.Event> {
            return eventSubject.asObservable()
        }

    }

}
