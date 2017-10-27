import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking
import RealmSwift
import RxRealm

@testable import SharedShoppingApp

class ShoppingServiceRealmSpec: QuickSpec {

    override func spec() {
        describe("ShoppingServiceRealm") {
            var sut: ShoppingServiceRealm!
            var realm: Realm!

            beforeEach {
                let realmConfig = Realm.Configuration(inMemoryIdentifier: "TestRealm")
                realm = try! Realm(configuration: realmConfig)
                try! realm.write { realm.deleteAll() }
                sut = ShoppingServiceRealm(realm: realm)
            }

            it("should have no shoppings") {
                expect(try! sut.shoppings.toBlocking().first()).to(equal([]))
            }

            context("create shopping") {
                var shopping: Shopping!

                beforeEach {
                    shopping = sut.createShopping()
                }

                it("should have one shopping") {
                    expect(try! sut.shoppings.toBlocking().first()).to(equal([shopping]))
                }

                context("remove shopping") {
                    beforeEach {
                        sut.removeShopping(shopping)
                    }

                    it("should have no shoppings") {
                        expect(try! sut.shoppings.toBlocking().first()).to(equal([]))
                    }
                }

                context("remove invalid shopping") {
                    beforeEach {
                        sut.removeShopping(ShoppingStruct(name: "Invalid", date: Date()))
                    }

                    it("should have one shopping") {
                        expect(try! sut.shoppings.toBlocking().first()).to(equal([shopping]))
                    }
                }
            }
        }
    }

}
