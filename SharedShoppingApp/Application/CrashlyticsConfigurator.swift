import Foundation

class CrashlyticsConfigurator: AppConfiguring {

    init(apiKeyURL: URL, start: @escaping (String) -> Void) {
        self.apiKeyURL = apiKeyURL
        self.start = start
    }

    // MARK: AppConfiguring

    func configure() {
        start(fabricApiKey)
    }

    // MARK: Private

    private let apiKeyURL: URL
    private let start: (String) -> Void

    private var fabricApiKey: String {
        // swiftlint:disable force_unwrapping force_try
        let data = try! Data(contentsOf: apiKeyURL)
        return String(data: data, encoding: .utf8)!
    }

}
