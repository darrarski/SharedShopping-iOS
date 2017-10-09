import Foundation

extension Container {

    func shoppingsTableRowViewModel(shopping: Shopping) -> ShoppingsTableRowViewModel {
        return ShoppingsTableRowViewModel(shopping: shopping, assembly: Assembly())
    }

    private struct Assembly: ShoppingsTableRowViewModelAssembly {

        // MARK: ShoppingsTableRowViewModelAssembly

        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }

    }

}
