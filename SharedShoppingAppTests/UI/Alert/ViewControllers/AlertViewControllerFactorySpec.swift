import Quick
import Nimble

@testable import SharedShoppingApp

class AlertViewControllerFactorySpec: QuickSpec {

    override func spec() {
        describe("AlertViewControllerFactory") {
            var sut: AlertViewControllerFactory!

            beforeEach {
                sut = AlertViewControllerFactory(actionFactory: {
                    UIAlertActionSpy.create(title: $0, style: $1, handler: $2)
                })
            }

            context("create view controller") {
                var viewModel: AlertViewModel!
                var viewController: UIAlertController?
                var didConfirm: Bool!
                var didCancel: Bool!
                var didDestruct: Bool!

                beforeEach {
                    didConfirm = false
                    didCancel = false
                    didDestruct = false
                    viewModel = AlertViewModel(
                        title: "Test Alert Title",
                        message: "Test Alert Message",
                        actions: [
                            AlertActionViewModel(
                                title: "Confirm",
                                style: .confirm,
                                handler: { didConfirm = true }
                            ),
                            AlertActionViewModel(
                                title: "Cancel",
                                style: .cancel,
                                handler: { didCancel = true }
                            ),
                            AlertActionViewModel(
                                title: "Destruct",
                                style: .destruct,
                                handler: { didDestruct = true }
                            )
                        ]
                    )
                    viewController = sut.createAlertViewController(viewModel: viewModel) as? UIAlertController
                }

                it("should create UIAlertController") {
                    expect(viewController).notTo(beNil())
                }

                it("should set title") {
                    expect(viewController?.title).to(equal(viewModel.title))
                }

                it("should set message") {
                    expect(viewController?.message).to(equal(viewModel.message))
                }

                it("should set all actions") {
                    expect(viewController?.actions).to(haveCount(viewModel.actions.count))
                }

                describe("first action") {
                    var actionSpy: UIAlertActionSpy?

                    beforeEach {
                        actionSpy = viewController?.actions[0] as? UIAlertActionSpy
                    }

                    it("should have correct title") {
                        expect(actionSpy?.title).to(equal(viewModel.actions[0].title))
                    }

                    it("should have correct style") {
                        expect(actionSpy?.style.rawValue).to(equal(UIAlertActionStyle.default.rawValue))
                    }

                    context("perform") {
                        beforeEach {
                            actionSpy!.handler?(actionSpy!)
                        }

                        it("should confirm") {
                            expect(didConfirm).to(beTrue())
                        }
                    }
                }

                describe("second action") {
                    var actionSpy: UIAlertActionSpy?

                    beforeEach {
                        actionSpy = viewController?.actions[1] as? UIAlertActionSpy
                    }

                    it("should have correct title") {
                        expect(actionSpy?.title).to(equal(viewModel.actions[1].title))
                    }

                    it("should have correct style") {
                        expect(actionSpy?.style.rawValue).to(equal(UIAlertActionStyle.cancel.rawValue))
                    }

                    context("perform") {
                        beforeEach {
                            actionSpy!.handler?(actionSpy!)
                        }

                        it("should confirm") {
                            expect(didCancel).to(beTrue())
                        }
                    }
                }

                describe("third action") {
                    var actionSpy: UIAlertActionSpy?

                    beforeEach {
                        actionSpy = viewController?.actions[2] as? UIAlertActionSpy
                    }

                    it("should have correct title") {
                        expect(actionSpy?.title).to(equal(viewModel.actions[2].title))
                    }

                    it("should have correct style") {
                        expect(actionSpy?.style.rawValue).to(equal(UIAlertActionStyle.destructive.rawValue))
                    }

                    context("perform") {
                        beforeEach {
                            actionSpy!.handler?(actionSpy!)
                        }

                        it("should destruct") {
                            expect(didDestruct).to(beTrue())
                        }
                    }
                }
            }
        }
    }

}
