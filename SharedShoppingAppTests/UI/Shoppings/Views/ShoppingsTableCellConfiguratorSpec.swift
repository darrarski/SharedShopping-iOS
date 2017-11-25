import Quick
import Nimble
@testable import SharedShoppingApp

class ShoppingsTableCellConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsTableCellConfigurator") {
            var sut: ShoppingsTableCellConfigurator!
            var cell: ShoppingsTableCell!
            var rowViewModel: ShoppingsTableRowViewModel!

            beforeEach {
                sut = ShoppingsTableCellConfigurator()
                cell = ShoppingsTableCell(style: .default, reuseIdentifier: "shopping")
                rowViewModel = ShoppingsTableRowViewModel(
                    dateFormatter: DateFormatter(),
                    rowActionFactory: { _, _, _ in fatalError() },
                    shoppingRemover: ShoppingRemoverSpy(),
                    shoppingPresenter: ShoppingPresenterSpy(),
                    alertPresenter: AlertPresenterSpy(),
                    shopping: ShoppingFake(name: "Fake Shopping", date: Date())
                )
            }

            it("should can configure") {
                expect(sut.canConfigure(cell, with: rowViewModel)).to(beTrue())
            }

            context("configure") {
                beforeEach {
                    sut.configure(cell, with: rowViewModel)
                }

                it("should set correct title") {
                    expect(cell.titleLabel.text).to(equal(rowViewModel.title))
                }

                it("should set correct subtitle") {
                    expect(cell.subtitleLabel.text).to(equal(rowViewModel.subtitle))
                }
            }
        }
    }

}
