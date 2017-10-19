import Nimble
import Foundation

func onSimulator(_ file: FileString = #file, line: UInt = #line, _ closure: () -> Void) {
    #if arch(x86_64) && (os(macOS) || os(iOS) || os(tvOS) || os(watchOS)) && !SWIFT_PACKAGE
        closure()
    #else
        let url = URL(fileURLWithPath: file)
        print("\(url.lastPathComponent):\(line) - execution skipped (not on simulator)")
    #endif
}
