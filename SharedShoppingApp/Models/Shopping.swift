import Foundation

struct Shopping {
    let name: String
    let date: Date
}

extension Shopping: Equatable {

    public static func == (lhs: Shopping, rhs: Shopping) -> Bool {
        return lhs.name == rhs.name &&
               lhs.date == rhs.date
    }

}
