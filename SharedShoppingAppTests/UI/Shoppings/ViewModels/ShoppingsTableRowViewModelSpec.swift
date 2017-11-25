import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingsTableRowViewModelSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsTableRowViewModel") {
            var sut: ShoppingsTableRowViewModel!
            var dateFormatter: DateFormatter!
            var shoppingRemoverSpy: ShoppingRemoverSpy!
            var shoppingPresenterSpy: ShoppingPresenterSpy!
            var alertPresenterSpy: AlertPresenterSpy!
            var shopping: Shopping!

            beforeEach {
                dateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .long
                    formatter.timeStyle = .long
                    return formatter
                }()
                shoppingRemoverSpy = ShoppingRemoverSpy()
                shoppingPresenterSpy = ShoppingPresenterSpy()
                alertPresenterSpy = AlertPresenterSpy()
                shopping = ShoppingFake(name: "Test Shopping", date: Date())

                sut = ShoppingsTableRowViewModel(
                    dateFormatter: dateFormatter,
                    rowActionFactory: { style, title, handler in
                        UITableViewRowActionSpy.create(style: style, title: title, handler: handler)
                    },
                    shoppingRemover: shoppingRemoverSpy,
                    shoppingPresenter: shoppingPresenterSpy,
                    alertPresenter: alertPresenterSpy,
                    shopping: shopping
                )
            }

            describe("other ShoppingsTableRowViewModel with same Shopping") {
                var other: ShoppingsTableRowViewModel!

                beforeEach {
                    other = ShoppingsTableRowViewModel(
                        dateFormatter: DateFormatter(),
                        rowActionFactory: { UITableViewRowAction(style: $0, title: $1, handler: $2) },
                        shoppingRemover: ShoppingRemoverSpy(),
                        shoppingPresenter: ShoppingPresenterSpy(),
                        alertPresenter: AlertPresenterSpy(),
                        shopping: shopping
                    )
                }

                it("should be equal") {
                    expect(sut.isEqual(to: other)).to(beTrue())
                    expect(other.isEqual(to: sut)).to(beTrue())
                }
            }

            describe("other ShoppingsTableRowViewModel with other Shopping") {
                var other: ShoppingsTableRowViewModel!

                beforeEach {
                    other = ShoppingsTableRowViewModel(
                        dateFormatter: dateFormatter,
                        rowActionFactory: { style, title, handler in
                            UITableViewRowActionSpy.create(style: style, title: title, handler: handler)
                        },
                        shoppingRemover: shoppingRemoverSpy,
                        shoppingPresenter: shoppingPresenterSpy,
                        alertPresenter: alertPresenterSpy,
                        shopping: ShoppingFake(name: "Other Shopping", date: Date())
                    )
                }

                it("should not be equal") {
                    expect(sut.isEqual(to: other)).notTo(beTrue())
                    expect(other.isEqual(to: sut)).notTo(beTrue())
                }
            }

            describe("other TableRowViewModel with same Shopping") {
                var other: TableRowViewModel!

                beforeEach {
                    other = TableRowViewModelStub(shopping: shopping)
                }

                it("should not be equal") {
                    expect(sut.isEqual(to: other)).notTo(beTrue())
                    expect(other.isEqual(to: sut)).notTo(beTrue())
                }
            }

            describe("other TableRowViewModel with other Shopping") {
                var other: TableRowViewModel!

                beforeEach {
                    other = TableRowViewModelStub(shopping: ShoppingFake(name: "Other Shopping", date: Date()))
                }

                it("should not be equal") {
                    expect(sut.isEqual(to: other)).notTo(beTrue())
                    expect(other.isEqual(to: sut)).notTo(beTrue())
                }
            }

            context("register in table view") {
                var tableView: UITableViewSpy!

                beforeEach {
                    tableView = UITableViewSpy()
                    sut.register(in: tableView)
                }

                it("should register correct cell") {
                    expect(tableView.registerCellClassForCellReuseIdentifierCalled?.0).to(be(ShoppingsTableCell.self))
                }

                it("should register correct identifier") {
                    expect(tableView.registerCellClassForCellReuseIdentifierCalled?.1).to(equal("shopping"))
                }
            }

            it("should have correct estimated height") {
                expect(sut.estimatedHeight).to(equal(60))
            }

            it("should have correct heught") {
                expect(sut.height).to(equal(UITableViewAutomaticDimension))
            }

            describe("cell at index path in table view") {
                var indexPath: IndexPath!
                var tableView: UITableViewSpy!
                var cellStub: ShoppingsTableCell!
                var cell: UITableViewCell?

                beforeEach {
                    indexPath = IndexPath(row: 12, section: 17)
                    tableView = UITableViewSpy()
                    tableView.cellStub = { identifier in
                        cellStub = ShoppingsTableCell(style: .default, reuseIdentifier: identifier)
                        return cellStub
                    }
                    cell = sut.cell(at: indexPath, in: tableView) as? ShoppingsTableCell
                }

                it("should be dequeued with correct identifier") {
                    expect(tableView.dequeueReusableCellWithIdentifierForIndexPathCalled?.0).to(equal("shopping"))
                }

                it("should be dequeued with correct index path") {
                    expect(tableView.dequeueReusableCellWithIdentifierForIndexPathCalled?.1).to(equal(indexPath))
                }

                it("should be correct") {
                    expect(cell).to(be(cellStub))
                }

                it("should have correct title") {
                    expect(cellStub.titleLabel.text).to(equal(shopping.name))
                }

                it("should have correct date") {
                    expect(cellStub.subtitleLabel.text).to(equal(dateFormatter.string(from: shopping.date)))
                }
            }

            it("should have one action") {
                expect(sut.actions).to(haveCount(1))
            }

            describe("first action") {
                var action: UITableViewRowAction?

                beforeEach {
                    action = sut.actions?.first
                }

                it("should have correct style") {
                    expect(action?.style).to(equal(UITableViewRowActionStyle.destructive))
                }

                it("should have correct title") {
                    expect(action?.title).to(equal("Delete"))
                }

                context("perform") {
                    beforeEach {
                        guard let action = action as? UITableViewRowActionSpy else { return }
                        action.handler(action, IndexPath(row: 12, section: 17))
                    }

                    describe("presented alert") {
                        var alert: AlertViewModel?

                        beforeEach {
                            alert = alertPresenterSpy.didPresentAlert
                        }

                        it("should not be nil") {
                            expect(alert).notTo(beNil())
                        }

                        it("should have correct title") {
                            expect(alert?.title).to(equal("Delete Shopping"))
                        }

                        it("should have correct message") {
                            expect(alert?.message).to(equal("Are you sure you want to delete selected Shopping with all contained data?"))
                        }

                        it("should have two actions") {
                            expect(alert?.actions).to(haveCount(2))
                        }

                        describe("first action") {
                            var action: AlertActionViewModel?

                            beforeEach {
                                action = alert?.actions.first
                            }

                            it("should have correct title") {
                                expect(action?.title).to(equal("Cancel"))
                            }

                            it("should have correct style") {
                                expect(action?.style).to(equal(AlertActionViewModel.Style.cancel))
                            }

                            context("perform") {
                                beforeEach {
                                    action?.handler()
                                }

                                it("should not delete shopping") {
                                    expect(shoppingRemoverSpy.didRemoveShopping).to(beNil())
                                }
                            }
                        }

                        describe("last action") {
                            var action: AlertActionViewModel?

                            beforeEach {
                                action = alert?.actions.last
                            }

                            it("should have correct title") {
                                expect(action?.title).to(equal("Delete"))
                            }

                            it("should have correct style") {
                                expect(action?.style).to(equal(AlertActionViewModel.Style.destruct))
                            }

                            context("perform") {
                                beforeEach {
                                    action?.handler()
                                }

                                it("should delete shopping") {
                                    expect(shoppingRemoverSpy.didRemoveShopping).to(equal(shopping))
                                }
                            }
                        }
                    }
                }
            }

            context("select") {
                beforeEach {
                    sut.didSelect()
                }

                it("should present Shopping") {
                    expect(shoppingPresenterSpy.didPresentShopping).to(equal(shopping))
                }
            }
        }
    }

}
