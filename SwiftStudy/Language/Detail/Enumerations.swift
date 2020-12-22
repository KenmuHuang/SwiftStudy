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
    }
}