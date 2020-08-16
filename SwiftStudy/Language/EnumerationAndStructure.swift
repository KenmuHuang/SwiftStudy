//
// Created by KenmuHuang on 2020/8/16.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import UIKit

class EnumerationAndStructure {
    func main() -> Void {
        // 枚举
        let ace = Rank.ace
        let aceRawValue = ace.rawValue
        print("aceRawValue = \(aceRawValue), \(ace.simpleDescription())")

        if let convertedRank = Rank(rawValue: 11) {
            let threeDescription = convertedRank.simpleDescription()
            print(threeDescription)
        }

        let hearts = Suit.hearts
        let heartsDescription = hearts.simpleDescription()
        print("\(heartsDescription), \(hearts.color())")

        let success = ServerResponse.result("6:00 am", "8:09 pm")
        print(success.simpleDescription())

        let failure = ServerResponse.failure("Out of cheese")
        print(failure.simpleDescription())

        // 结构；跟类的重要区别是：结构在代码中传递时始终会被复制，而类是通过引用传递的
        let threeOfSpades = Card(rank: .three, suit: .spades)
        print(threeOfSpades.simpleDescription())
    }
}

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

enum Suit: Int {
    case spades, hearts, diamonds, clubs

    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts, \(String(self.rawValue))"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }

    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "blank color"
        case .hearts, .diamonds:
            return "red color"
        }
    }
}

enum ServerResponse {
    case result(String, String)
    case failure(String)
    case error(String)

    func simpleDescription() -> String {
        switch self {
        case let .result(sunrise, sunset):
            return "Sunrise is at \(sunrise) and sunset is at \(sunset)."
        case let .failure(message):
            return "Failure...  \(message)"
        case let .error(message):
            return "Error... \(message)"
        }
    }
}

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}