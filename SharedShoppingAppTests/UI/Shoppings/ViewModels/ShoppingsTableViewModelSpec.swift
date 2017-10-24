import Quick
import Nimble
import RxSwift
import RxTest

@testable import SharedShoppingApp

class ShoppingsTableViewModelSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsTableViewModel") {
            var sut: ShoppingsTableViewModel!
            var shoppingsProviderStub: ShoppingsProviderStub!

            beforeEach {
                shoppingsProviderStub = ShoppingsProviderStub()
                shoppingsProviderStub.shoppingsVar.value = [
                    Shopping(name: "Shopping 1", date: Date()),
                    Shopping(name: "Shopping 2", date: Date()),
                    Shopping(name: "Shopping 3", date: Date()),
                    Shopping(name: "Shopping 4", date: Date())
                ]
                sut = ShoppingsTableViewModel(
                    shoppingsProvider: shoppingsProviderStub,
                    rowViewModelFactory: { TableRowViewModelStub(shopping: $0) }
                )
            }

            it("should have four rows in first section") {
                expect(sut.numberOfRows(in: 0)).to(equal(4))
            }

            it("should throw when asked for number of rows in second section") {
                onSimulator {
                    expect { _ = sut.numberOfRows(in: 1) }.to(throwAssertion())
                }
            }

            describe("row view model at row 0 in section 0") {
                var rowViewModel: TableRowViewModel!

                beforeEach {
                    rowViewModel = sut.rowViewModel(at: IndexPath(row: 0, section: 0))
                }

                it("should be a stub") {
                    expect(rowViewModel).to(beAKindOf(TableRowViewModelStub.self))
                }

                it("should have correct shopping") {
                    expect((rowViewModel as? TableRowViewModelStub)?.shopping)
                        .to(equal(shoppingsProviderStub.shoppingsVar.value.first))
                }
            }

            it("should throw when asked for row view model at row 0 in section 1") {
                onSimulator {
                    expect { _ = sut.rowViewModel(at: IndexPath(row: 0, section: 1)) }.to(throwAssertion())
                }
            }

            context("remove last Shopping") {
                var scheduler: TestScheduler!
                var eventObserver: TestableObserver<TableViewController.Event>!

                beforeEach {
                    scheduler = TestScheduler(initialClock: 0)
                    eventObserver = scheduler.createObserver(TableViewController.Event.self)
                    _ = sut.event.subscribe(eventObserver)

                    shoppingsProviderStub.shoppingsVar.value.removeLast()
                }

                it("should have three rows in first section") {
                    expect(sut.numberOfRows(in: 0)).to(equal(3))
                }

                it("should emit correct event") {
                    let expectation: [Recorded<Event<TableViewController.Event>>] = [
                        next(0, .update([.delete(row: 3, inSection: 0)]))
                    ]
                    expect(eventObserver.events.debugDescription).to(equal(expectation.debugDescription))
                }

                context("insert shopping at index 0") {
                    beforeEach {
                        let shopping = Shopping(name: "Inserted Shopping", date: Date())
                        shoppingsProviderStub.shoppingsVar.value.insert(shopping, at: 0)
                    }

                    it("should emit correct event") {
                        let expectation: [Recorded<Event<TableViewController.Event>>] = [
                            next(0, .update([.delete(row: 3, inSection: 0)])),
                            next(0, .update([.insert(row: 0, inSection: 0)]))
                        ]
                        expect(eventObserver.events.debugDescription).to(equal(expectation.debugDescription))
                    }
                }
            }
        }
    }

}
