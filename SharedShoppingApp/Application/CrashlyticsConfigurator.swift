import Foundation
import Crashlytics

class CrashlyticsConfigurator: AppConfiguring {

    func configure() {
        Crashlytics.start(withAPIKey: fabricApiKey)
    }

    private var fabricApiKey: String {
        // swiftlint:disable force_unwrapping force_try
        let url = Bundle.main.url(forResource: "fabric", withExtension: "apikey")!
        let data = try! Data(contentsOf: url)
        return String(data: data, encoding: .utf8)!
    }

}
