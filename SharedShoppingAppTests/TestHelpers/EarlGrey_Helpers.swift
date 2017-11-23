import EarlGrey

extension EarlGrey {

    class func presentViewController(_ viewController: UIViewController) {
        GREYTestHelper.enableFastAnimation()
        UIApplication.shared.keyWindow!.rootViewController = viewController
        GREYUIThreadExecutor.sharedInstance().drainUntilIdle()
    }

    class func cleanUpAfterPresentingViewController() {
        UIApplication.shared.keyWindow!.rootViewController = nil
        GREYTestHelper.disableFastAnimation()
    }

}

func grey_accessibilityElement(_ element: UIAccessibilityIdentification) -> GREYMatcher {
    let identifier = UUID().uuidString
    element.accessibilityIdentifier = identifier
    return grey_accessibilityID(identifier)
}
