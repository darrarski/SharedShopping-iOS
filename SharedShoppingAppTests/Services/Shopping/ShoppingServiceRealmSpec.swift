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
                let realmConfig = Realm.Configuration(inMemoryIdentifier: "ShoppingServiceRealmSpec")
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
                    shopping = sut.createShopping(name: "Shopping")
                }

                it("should have one shopping") {
                    expect(try! sut.shoppings.toBlocking().first()).to(equal([shopping]))
                }

                it("should created shopping have correct name") {
                    expect(try! sut.shoppings.toBlocking().first()!.first!.name).to(equal("Shopping"))
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
                        sut.removeShopping(ShoppingFake(name: "Invalid", date: Date()))
                    }

                    it("should have one shopping") {
                        expect(try! sut.shoppings.toBlocking().first()).to(equal([shopping]))
                    }
                }
            }

            describe("with some shoppings") {
                var shopping1: Shopping!
                var shopping2: Shopping!
                var shopping3: Shopping!
                var shopping4: Shopping!
                var shopping5: Shopping!

                func createShopping(name: String, date: Date) -> Shopping {
                    let shopping = ShoppingRealm()
                    shopping.name = name
                    shopping.date = date
                    try! realm.write { realm.add(shopping) }
                    return shopping
                }

                beforeEach {
                    shopping3 = createShopping(name: "Shopping 3", date: Date(timeIntervalSince1970: 30))
                    shopping5 = createShopping(name: "Shopping 5", date: Date(timeIntervalSince1970: 50))
                    shopping1 = createShopping(name: "Shopping 1", date: Date(timeIntervalSince1970: 10))
                    shopping4 = createShopping(name: "Shopping 4", date: Date(timeIntervalSince1970: 40))
                    shopping2 = createShopping(name: "Shopping 2", date: Date(timeIntervalSince1970: 20))
                }

                it("should have shoppings ordered by date") {
                    expect(try! sut.shoppings.toBlocking().first()).to(equal([
                        shopping1,
                        shopping2,
                        shopping3,
                        shopping4,
                        shopping5
                    ]))
                }

                context("add shopping") {
                    var newShopping: Shopping!

                    beforeEach {
                        newShopping = createShopping(name: "New Shopping", date: Date(timeIntervalSince1970: 31))
                    }

                    it("should have correct shoppings") {
                        expect(try! sut.shoppings.toBlocking().first()).to(equal([
                            shopping1,
                            shopping2,
                            shopping3,
                            newShopping,
                            shopping4,
                            shopping5
                        ]))
                    }
                }

                context("remove shopping") {
                    beforeEach {
                        sut.removeShopping(shopping2)
                    }

                    it("should have correct shoppings") {
                        expect(try! sut.shoppings.toBlocking().first()).to(equal([
                            shopping1,
                            shopping3,
                            shopping4,
                            shopping5
                        ]))
                    }
                }
            }
        }
    }

}
