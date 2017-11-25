import Quick
import Nimble
@testable import SharedShoppingApp

class TableCellConfiguringSpec: QuickSpec {

    override func spec() {
        describe("TableCellConfiguring") {
            var sut: TableCellConfiguring!

            beforeEach {
                sut = Configurator()
            }

            it("should configure ConfigurableCell with ConfigurableRowViewModel") {
                expect(sut.canConfigure(ConfigurableCell(), with: ConfigurableRowViewModel())).to(beTrue())
            }

            it("should not configure ConfigurableCell with OtherRowViewModel") {
                expect(sut.canConfigure(ConfigurableCell(), with: OtherRowViewModel())).to(beFalse())
            }

            it("should not configure OtherCell with ConfigurableRowViewModel") {
                expect(sut.canConfigure(OtherCell(), with: ConfigurableRowViewModel())).to(beFalse())
            }

            it("should not configure OtherCell with OtherRowViewModel") {
                expect(sut.canConfigure(OtherCell(), with: OtherRowViewModel())).to(beFalse())
            }
        }
    }

    private class Configurator: TableCellConfiguring {
        static var cellType: UITableViewCell.Type { return ConfigurableCell.self }
        static var rowViewModelType: TableRowViewModel.Type { return ConfigurableRowViewModel.self }
        func configure(_ cell: UITableViewCell, with rowViewModel: TableRowViewModel) {}
    }

    private class ConfigurableCell: UITableViewCell {}

    private class OtherCell: UITableViewCell {}

    private class ConfigurableRowViewModel: TableRowViewModel {
        static var cellIdentifier: String { return "" }
        var estimatedHeight: CGFloat = 0
        var height: CGFloat = 0
        let actions: [TableRowAction]? = nil
        func isEqual(to other: TableRowViewModel) -> Bool { return false }
        func didSelect() {}
    }

    private class OtherRowViewModel: TableRowViewModel {
        static var cellIdentifier: String { return "" }
        var estimatedHeight: CGFloat = 0
        var height: CGFloat = 0
        let actions: [TableRowAction]? = nil
        func isEqual(to other: TableRowViewModel) -> Bool { return false }
        func didSelect() {}
    }

}
