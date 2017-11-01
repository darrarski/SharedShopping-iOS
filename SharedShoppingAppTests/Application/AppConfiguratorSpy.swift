@testable import SharedShoppingApp

class AppConfiguratorSpy: AppConfiguring {

    var didConfigure = false

    // MARK: AppConfiguring

    func configure() {
        didConfigure = true
    }

}
