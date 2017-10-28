import Quick
import Nimble
import RealmSwift

@testable import SharedShoppingApp

class ShoppingRealmSpec: QuickSpec {

    override func spec() {
        describe("ShoppingRealm") {
            var sut: ShoppingRealm!
            var realm: Realm!

            beforeEach {
                let realmConfig = Realm.Configuration(inMemoryIdentifier: "ShoppingRealmSpec")
                realm = try! Realm(configuration: realmConfig)
                sut = ShoppingRealm()
                sut.name = "Test Shopping"
                sut.date = Date(timeIntervalSince1970: 0)
                try! realm.write {
                    realm.deleteAll()
                    realm.add(sut)
                }
            }

            it("should be equal to different instance of the same ShoppingRealm") {
                let other = realm.objects(ShoppingRealm.self).first!
                expect(sut.isEqual(to: other)).to(beTrue())
            }

            it("should not be equal to different ShoppingRealm") {
                let other = ShoppingRealm()
                expect(sut.isEqual(to: other)).to(beFalse())
            }

            it("should not be equal to different Shopping") {
                let other = ShoppingFake(name: "Test Shopping", date: Date(timeIntervalSince1970: 0))
                expect(sut.isEqual(to: other)).to(beFalse())
            }
        }
    }

}
