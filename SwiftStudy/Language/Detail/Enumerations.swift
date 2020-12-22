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


        // 关联值
        // 存储不同类型关联值的枚举成员
        /// 条形码枚举
        /// upc - 四个整型值的元组存储 UPC 码，分别为「数字系统、厂商、产品、检查位」
        /// qrCode - 任意长度的字符串储存 QR 码
        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrCode(String)
        }

        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        productBarcode = Barcode.qrCode("ABCDEFGH")

        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(var productCode):
            print("QR code: \(productCode).")

            productCode = "IJK"
        }


        // 原始值
        // 存储相同类型关联值的枚举成员。原始值可以是字符串、字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的
        enum ASCIIControlCharacter: Character {
            case tab = "\t"
            case lineFeed = "\n"
            case carriageReturn = "\r"
        }

        // 当使用整数作为原始值时，隐式赋值的值依次递增 1。如果第一个枚举成员没有设置原始值，其原始值将为 0
        /// 行星枚举
        /// mercury - 水星，venus - 金星，earth - 地球，mars - 火星，jupiter - 木星，saturn - 土星，uranus - 天王星，neptune - 海王星
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        }

        // 当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称
        enum Name: String {
            case km, hc
        }

        // 使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值
        print("Planet.earth.rawValue = \(Planet.earth.rawValue), Name.km.rawValue = \(Name.km.rawValue)")

        // 使用原始值初始化枚举实例
        // 并非所有 Int 值都可以找到一个匹配的行星。因此，原始值构造器总是返回一个可选的枚举成员
        let positionToFind = 11
        if let somePlanet = Planet(rawValue: 7) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans, current place is \(somePlanet)")
            }
        } else {
            print("There isn't a planet at position \(positionToFind)")
        }
    }
}
