//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 扩展：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/20_extensions
class Extensions: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        extensionSyntax()
        computedProperties()
        initializers()
        methods()
        subscripts()
        nestedTypes()
    }
}

// MARK: - 扩展的语法
private func extensionSyntax() {
    /*
     扩展可以给一个现有的类，结构体，枚举，还有协议添加新的功能。它还拥有不需要访问被扩展类型源代码就能完成扩展的能力（即逆向建模）。扩展和 Objective-C 的分类很相似。（与 Objective-C 分类不同的是，Swift 扩展是没有名字的。）
     Swift 中的扩展可以：
     1、添加计算型实例属性和计算型类属性
     2、定义实例方法和类方法
     3、提供新的构造器
     4、定义下标
     5、定义和使用新的嵌套类型
     6、使已经存在的类型遵循（conform）一个协议

     注意：扩展可以给一个类型添加新的功能，但是不能重写已经存在的功能。
     */
}

// MARK: - 计算型属性
private func computedProperties() {
    let oneInch = 25.4.mm
    print("One inch is \(oneInch) meters")

    let threeFeet = 3.ft
    print("Three feet is \(threeFeet) meters")

    let aMarathon = 42.km + 195.m
    print("A marathon is \(aMarathon) meters long")
}

extension Double {
    /*
     注意：扩展可以添加新的计算属性，但是它们不能添加存储属性，或向现有的属性添加属性观察者。
     */

    /// 千米
    var km: Double { return self * 1_000.0 }

    /// 米
    var m: Double { return self }

    /// 厘米
    var cm: Double { return self / 100.0 }

    /// 毫米
    var mm: Double { return self / 1_000.0 }

    /// 英尺
    var ft: Double { return self / 3.28084 }
}

// MARK: - 构造器
private func initializers() {
    let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
    print("centerRect.origin = \(centerRect.origin)")
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    /*
     注意：如果你通过扩展提供一个新的构造器，你有责任确保每个通过该构造器创建的实例都是初始化完整的。
     */

    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2

        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

// MARK: - 方法
private func methods() {
    3.repetitions {
        print("Hello!")
    }

    // 可变实例方法
    var someInt = 3
    someInt.square()
    print("The someInt is \(someInt) after executing method of square")
}

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }

    mutating func square() {
        self = self * self
    }
}

// MARK: - 下标
private func subscripts() {
    /*
     下标 [n] 从数字右侧开始，返回第 n 位值：
     123456789[0] 返回 9
     123456789[1] 返回 8
     如果操作的 Int 值没有足够的位数满足所请求的下标，那么下标的现实将返回 0，将好像在数字的左边补上了 0
     */
    let someInt = 746381295
    print("The someInt = \(someInt)")

    let decimalCount = String(someInt).count
    for index in 0..<decimalCount {
        print("The someInt[\(index)] = \(someInt[index])")
    }
    print("The someInt[\(decimalCount)] = \(someInt[decimalCount])")
}

extension Int {
    subscript(index: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<index {
            decimalBase *= 10
        }
        return self / decimalBase % 10
    }
}

// MARK: - 嵌套类型
private func nestedTypes() {
    printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
}

extension Int {
    /*
     1、新的嵌套枚举 Kind：表示特定整数所代表的数字类型。具体来说，它表示数字是负的、零的还是正的
     2、新的计算型实例属性 kind：它返回被操作整数所对应的 Kind 枚举 case 分支
     */
    enum Kind {
        case negative, zero, positive
    }

    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where  x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("-", terminator: " ")
        case .zero:
            print("0", terminator: " ")
        case .positive:
            print("+", terminator: " ")
        }
    }
}