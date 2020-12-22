//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 枚举：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/08_enumerations
class Enumerations: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        // 枚举语法
        // 与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。east 不会隐式赋值为 0
        enum CompassPoint {
            case east
            case south
            case west
            case north
        }

        // 多个成员值可以出现在同一行上，用逗号隔开
        enum CompassPointBySingleLine {
            case east, south, west, north
        }

        // 值初始化时推断出类型后，可使用更简短的点语法
        var directionToHead = CompassPoint.east
        directionToHead = .south
        print("directionToHead = \(directionToHead)")

        var directionToHeadBySingleLine = CompassPointBySingleLine.north
        directionToHeadBySingleLine = .west


        // 使用 Switch 语句匹配枚举值
        switch directionToHead {
        case .east:
            print("Where the sun rises")
        case .south:
            print("Watch out for penguins")
        case .west:
            print("Where the skies are blue")
        case .north:
            print("Lots of planets have a north")
        }

        // switch 语句必须穷举所有情况，当不需要匹配每个枚举成员的时候，你可以提供一个 default 分支来涵盖所有未明确处理的枚举成员
        switch directionToHeadBySingleLine {
        case .east:
            print("The sun rises from \(directionToHeadBySingleLine)")
        default:
            print("Other direction is \(directionToHeadBySingleLine)")
        }


        // 枚举成员的遍历
        enum Beverage: CaseIterable {
            case coffee, tea, juice
        }

        let numberOfChoices = Beverage.allCases.count
        print("\(numberOfChoices) beverages available as following: ")

        for beverage in Beverage.allCases {
            print(beverage)
        }
    }
}
