import EarlGrey

extension EarlGrey {

    class func presentViewController(_ viewController: UIViewController) {
        GREYTestHelper.enableFastAnimation()
        UIApplication.shared.keyWindow!.rootViewController = viewController
        let matcher = grey_accessibilityElement(viewController.view)
        EarlGrey.select(elementWithMatcher: matcher).assert(grey_sufficientlyVisible())
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
