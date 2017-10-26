import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingsTableRowViewModelSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsTableRowViewModel") {
            var sut: ShoppingsTableRowViewModel!
            var dateFormatter: DateFormatter!
            var shoppingRemoverSpy: ShoppingRemoverSpy!
            var shopping: Shopping!

            beforeEach {
                dateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .long
                    formatter.timeStyle = .long
                    return formatter
                }()
                shoppingRemoverSpy = ShoppingRemoverSpy()
                shopping = ShoppingFake(name: "Test Shopping", date: Date())

                sut = ShoppingsTableRowViewModel(
                    dateFormatter: dateFormatter,
                    rowActionFactory: { style, title, handler in
                        UITableViewRowActionSpy.create(style: style, title: title, handler: handler)
                    },
                    shoppingRemover: shoppingRemoverSpy,
                    shopping: shopping
                )
            }

            context("register in table view") {
                var tableView: UITableViewSpy!

                beforeEach {
                    tableView = UITableViewSpy()
                    sut.register(in: tableView)
                }

                it("should register correct cell") {
                    expect(tableView.registerCellClassForCellReuseIdentifierCalled?.0).to(be(ShoppingsTableViewCell.self))
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
                var cellStub: ShoppingsTableViewCell!
                var cell: UITableViewCell?

                beforeEach {
                    indexPath = IndexPath(row: 12, section: 17)
                    tableView = UITableViewSpy()
                    tableView.cellStub = { identifier in
                        cellStub = ShoppingsTableViewCell(style: .default, reuseIdentifier: identifier)
                        return cellStub
                    }
                    cell = sut.cell(at: indexPath, in: tableView) as? ShoppingsTableViewCell
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

                describe("when wrong cell is dequeued") {
                    beforeEach {
                        tableView.cellStub = { UITableViewCell(style: .default, reuseIdentifier: $0) }
                    }

                    it("should throw assertion") {
                        onSimulator {
                            expect { _ = sut.cell(at: IndexPath(row: 0, section: 0), in: tableView) }
                                .to(throwAssertion())
                        }
                    }
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

                    it("should delete shopping") {
                        expect(shoppingRemoverSpy.didRemoveShopping).to(equal(shopping))
                    }
                }
            }
        }
    }

}
