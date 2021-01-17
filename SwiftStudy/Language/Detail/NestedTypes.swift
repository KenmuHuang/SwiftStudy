//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 嵌套类型：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/19_nested_types
class NestedTypes: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        nestedTypesInAction()
        referringToNestedTypes()
    }

    // MARK: - 嵌套类型实践
    private func nestedTypesInAction() {
        let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
        print("theAceOfSpades: \(theAceOfSpades.description)")
    }

    ///
    /// 二十一点结构体
    struct BlackjackCard: CustomStringConvertible {
        ///
        /// 嵌套的花色枚举
        enum Suit: Character {
            case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
        }

        ///
        /// 嵌套的级别枚举
        enum Rank: Int {
            case two = 2, three, four, five, six, seven, eight, nine, ten
            case jack, queen, king, ace

            ///
            /// 嵌套的值结构体
            struct Values {
                let first: Int
                let second: Int?
            }

            var values: Values {
                switch self {
                case .ace:
                    return Values(first: 1, second: 11)
                case .jack, .queen, .king:
                    return Values(first: 10, second: nil)
                default:
                    return Values(first: self.rawValue, second: nil)
                }
            }
        }

        let rank: Rank
        let suit: Suit
        var description: String {
            var output = "suit is \(suit.rawValue)"
            output += " value is \(rank.values.first)"
            if let second = rank.values.second {
                output += " or \(second)"
            }
            return output
        }
    }

    // MARK: - 引用嵌套类型
    private func referringToNestedTypes() {
        let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
        print("heartsSymbol: \(heartsSymbol)")
    }
}