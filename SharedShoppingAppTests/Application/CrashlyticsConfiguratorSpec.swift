import Quick
import Nimble

@testable import SharedShoppingApp

class CrashlyticsConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("CrashlyticsConfigurator") {
            var sut: CrashlyticsConfigurator!
            var apiKey: String!
            var apiKeyURL: URL!
            var didStartWithApiKey: String?

            beforeEach {
                apiKey = "test-api-key"
                apiKeyURL = try! FileManager.default
                    .url(for: .applicationSupportDirectory,
                         in: .userDomainMask,
                         appropriateFor: nil,
                         create: true)
                    .appendingPathComponent("test-fabric-api-key")
                try! apiKey.data(using: .utf8)?.write(to: apiKeyURL)

                sut = CrashlyticsConfigurator(
                    apiKeyURL: apiKeyURL,
                    start: { didStartWithApiKey = $0 }
                )
            }

            afterEach {
                try! FileManager.default.removeItem(at: apiKeyURL)
            }

            context("configure") {
                beforeEach {
                    sut.configure()
                }

                it("should start with api key") {
                    expect(didStartWithApiKey).to(equal(apiKey))
                }
            }
        }
    }

}
