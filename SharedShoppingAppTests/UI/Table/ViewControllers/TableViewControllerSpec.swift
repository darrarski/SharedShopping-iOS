import Quick
import Nimble
import RxSwift

@testable import SharedShoppingApp

class TableViewControllerSpec: QuickSpec {

    override func spec() {
        describe("TableViewController") {
            var sut: TableViewController!

            context("init with coder") {
                beforeEach {
                    sut = TableViewController(coder: NSCoder())
                }

                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }

            context("init") {
                var cellFactorySpy: CellFactorySpy!
                var cellConfiguratorSpy: CellConfiguratorSpy!
                var rowActionFactory: TableViewRowActionCreating!
                var inputs: Inputs!

                beforeEach {
                    cellFactorySpy = CellFactorySpy()
                    cellConfiguratorSpy = CellConfiguratorSpy()
                    rowActionFactory = TableViewRowActionFactory()
                    inputs = Inputs()
                    sut = TableViewController(
                        style: .plain,
                        cellFactory: cellFactorySpy,
                        cellConfigurators: [cellConfiguratorSpy],
                        rowActionFactory: rowActionFactory,
                        inputs: inputs
                    )
                }

                context("load view") {
                    beforeEach {
                        _ = sut.view
                    }

                    it("should have footer view") {
                        expect(sut.tableView.tableFooterView).notTo(beNil())
                    }

                    it("should register cell factory") {
                        expect(cellFactorySpy.didRegisterInTableView).to(be(sut.tableView))
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
                            rowStub.actionsStub = [.delete(title: "Test Action", handler: {})]
                        }

                        it("should have correct estimated height") {
                            expect(sut.tableView(sut.tableView, estimatedHeightForRowAt: indexPath)).to(equal(rowStub.estimatedHeightStub))
                            expect(rowStub.estimatedHeightCalled).to(beTrue())
                        }

                        it("should have correct height") {
                            expect(sut.tableView(sut.tableView, heightForRowAt: indexPath)).to(equal(rowStub.heightStub))
                            expect(rowStub.heightCalled).to(beTrue())
                        }

                        it("should have correct actions") {
                            let tableViewRowActions = sut.tableView(sut.tableView, editActionsForRowAt: indexPath)
                            expect(rowStub.actionsCalled).to(beTrue())
                            expect(tableViewRowActions).to(haveCount(1))
                            expect(tableViewRowActions?.first?.title).to(equal("Test Action"))
                            expect(tableViewRowActions?.first?.style).to(equal(UITableViewRowActionStyle.destructive))
                        }

                        describe("cell") {
                            var cell: UITableViewCell!

                            beforeEach {
                                cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
                            }

                            it("should have correct reuse identifier") {
                                expect(cell.reuseIdentifier).to(equal(type(of: rowStub).cellIdentifier))
                            }

                            it("should be configured with row view model") {
                                expect(cellConfiguratorSpy.didConfigureCellWithRowViewModel?.0).to(be(cell))
                                expect(cellConfiguratorSpy.didConfigureCellWithRowViewModel?.1).to(be(rowStub))
                            }
                        }
                    }

                    context("insert row") {
                        var rowViewModelStub: TableRowViewModelStub!
                        var methodCallObserver: MethodCallObserver!

                        beforeEach {
                            rowViewModelStub = TableRowViewModelStub(uid: "inserted")

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
                            expect(methodCallObserver.observedCalls.map { $0.selector.description }).to(equal([
                                #selector(sut.tableView.beginUpdates),
                                #selector(sut.tableView.insertRows(at:with:)),
                                #selector(sut.tableView.deleteRows(at:with:)),
                                #selector(sut.tableView.endUpdates)
                                ].map { $0.description }))
                        }

                        it("should pass correct params to insert rows method") {
                            let params = methodCallObserver.observedCalls[1].parameters
                            expect(params[0] as? [IndexPath]).to(equal([IndexPath(row: 7, section: 0)]))
                            expect(params[1] as? Int).to(equal(UITableViewRowAnimation.automatic.rawValue))
                        }

                        it("should pass correct params to delete rows method") {
                            let params = methodCallObserver.observedCalls[2].parameters
                            expect(params[0] as? [IndexPath]).to(equal([IndexPath(row: 10, section: 0)]))
                            expect(params[1] as? Int).to(equal(UITableViewRowAnimation.automatic.rawValue))
                        }
                    }

                    context("select cell") {
                        var indexPath: IndexPath!

                        beforeEach {
                            indexPath = IndexPath(row: 12, section: 0)
                            sut.tableView(sut.tableView, didSelectRowAt: indexPath)
                        }

                        it("should call didSelect on row") {
                            expect(inputs.rowViewModelsStub.value[indexPath.row].didSelectCalled).to(beTrue())
                        }
                    }
                }
            }
        }
    }

    private class CellFactorySpy: TableCellCreating {

        var didRegisterInTableView: UITableView?

        // MARK: TableCellCreating

        func register(in tableView: UITableView) {
            didRegisterInTableView = tableView
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }

        func cell(withId identifier: String, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
            return UITableViewCell(style: .default, reuseIdentifier: identifier)
        }

    }

    private class CellConfiguratorSpy: TableCellConfiguring {

        var didConfigureCellWithRowViewModel: (UITableViewCell, TableRowViewModel)?

        // MARK: TableCellConfiguring

        static var cellType: UITableViewCell.Type {
            return UITableViewCell.self
        }

        static var rowViewModelType: TableRowViewModel.Type {
            return TableRowViewModelStub.self
        }

        func configure(_ cell: UITableViewCell, with rowViewModel: TableRowViewModel) {
            didConfigureCellWithRowViewModel = (cell, rowViewModel)
        }

    }

    private class Inputs: TableViewControllerInputs {

        let rowViewModelsStub = Variable<[TableRowViewModelStub]>((1...15).map { index in
            TableRowViewModelStub(uid: "test_cell_\(index)")
        })

        // MARK: TableViewControllerInputs

        var rowViewModels: Observable<[TableRowViewModel]> {
            return rowViewModelsStub.asObservable().map { $0 as [TableRowViewModel] }
        }

    }

}
