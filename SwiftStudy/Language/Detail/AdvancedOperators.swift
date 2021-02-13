//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 高级运算符：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/27_advanced_operators
class AdvancedOperators: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        bitwiseOperators()
        overflowOperators()
        precedenceAndAssociativity()
        operatorFunctions()
        customOperators()
    }
}

// MARK: - 位运算符
private func bitwiseOperators() {
    /*
     与 C 语言中的算术运算符不同，Swift 中的算术运算符默认是不会溢出的。所有溢出行为都会被捕获并报告为错误。如果想让系统允许溢出行为，可以选择使用 Swift 中另一套默认支持溢出的运算符，比如溢出加法运算符（&+）。所有的这些溢出运算符都是以 & 开头的。

     自定义结构体、类和枚举时，如果也为它们提供标准 Swift 运算符的实现，将会非常有用。在 Swift 中为这些运算符提供自定义的实现非常简单，运算符也会针对不同类型使用对应实现。

     我们不用被预定义的运算符所限制。在 Swift 中可以自由地定义中缀、前缀、后缀和赋值运算符，它们具有自定义的优先级与关联值。这些运算符在代码中可以像预定义的运算符一样使用，你甚至可以扩展已有的类型以支持自定义运算符。
     */
    // Bitwise NOT Operator（按位取反运算符）：（~）对一个数值的全部比特位进行取反
    let initialBits: UInt8 = 0b00001111
    let invertedBits = ~initialBits
    print("\(String(initialBits, radix: 2)) 的按位取反运算符是 \(String(invertedBits, radix: 2))")


    // Bitwise AND Operator（按位与运算符）：（&） 对两个数的比特位进行合并。它返回一个新的数，只有当两个数的对应位都为 1 的时候，新数的对应位才为 1
    let firstSixBits: UInt8 = 0b11111100
    let lastSixBits: UInt8 = 0b00111111
    let middleFourBits = firstSixBits & lastSixBits
    print("\(String(firstSixBits, radix: 2)) 与 \(String(lastSixBits, radix: 2)) 的按位与运算符是 \(String(middleFourBits, radix: 2))")


    // Bitwise OR Operator（按位或运算符）：按位或运算符（|）可以对两个数的比特位进行比较。它返回一个新的数，只要两个数的对应位中有任意一个为 1 时，新数的对应位就为 1
    let someBits: UInt8 = 0b10110010
    let moreBits: UInt8 = 0b01011110
    let combinedBits = someBits | moreBits
    print("\(String(someBits, radix: 2)) 与 \(String(moreBits, radix: 2)) 的按位或运算符是 \(String(combinedBits, radix: 2))")


    // Bitwise XOR Operator（按位异或运算符）：按位异或运算符，或称“排外的或运算符”（^），可以对两个数的比特位进行比较。它返回一个新的数，当两个数的对应位不相同时，新数的对应位就为 1，并且对应位相同时则为 0
    let firstBits: UInt8 = 0b00010100
    let otherBits: UInt8 = 0b00000101
    let outputBits = firstBits ^ otherBits
    print("\(String(firstBits, radix: 2)) 与 \(String(otherBits, radix: 2)) 的按位异或运算符是 \(String(outputBits, radix: 2))")


    // Bitwise Left and Right Shift Operators（按位左移、右移运算符）
    /*
     对无符号整数进行移位的规则如下：
     1、已存在的位按指定的位数进行左移和右移。
     2、任何因移动而超出整型存储范围的位都会被丢弃。
     3、用 0 来填充移位后产生的空白位。
     这种方法称为逻辑移位。

     对比无符号整数，有符号整数的移位运算相对复杂得多，这种复杂性源于有符号整数的二进制表现形式。（为了简单起见，以下的示例都是基于 8 比特的有符号整数，但是其中的原理对任何位数的有符号整数都是通用的。）
     有符号整数使用第 1 个比特位（通常被称为符号位）来表示这个数的正负。符号位为 0 代表正数，为 1 代表负数。
     其余的比特位（通常被称为数值位）存储了实际的值。有符号正整数和无符号数的存储方式是一样的，都是从 0 开始算起。
     其次，使用二进制补码可以使负数的按位左移和右移运算得到跟正数同样的效果，即每向左移一位就将自身的数值乘以 2，每向右一位就将自身的数值除以 2。要达到此目的，对有符号整数的右移有一个额外的规则：当对有符号整数进行按位右移运算时，遵循与无符号整数相同的规则，但是对于移位产生的空白位使用符号位进行填充，而不是用 0。
     这个行为可以确保有符号整数的符号位不会因为右移运算而改变，这通常被称为算术移位。
     */
    let shiftBits: UInt8 = 4 // 即二进制的 00000100
    shiftBits << 1           // 00001000
    shiftBits << 2           // 00010000
    shiftBits << 5           // 10000000
    shiftBits << 6           // 00000000
    shiftBits >> 2           // 00000001

    let pink: UInt32 = 0xCC6699
    let redComponent = (pink & 0xFF0000) >> 16  // redComponent 是 0xCC，即 204
    let greenComponent = (pink & 0x00FF00) >> 8 // greenComponent 是 0x66， 即 102
    let blueComponent = pink & 0x0000FF         // blueComponent 是 0x99，即 153

}

// MARK: - 溢出运算符
private func overflowOperators() {
    /*
     当向一个整数类型的常量或者变量赋予超过它容量的值时，Swift 默认会报错，而不是允许生成一个无效的数。这个行为为我们在运算过大或者过小的数时提供了额外的安全性。

     然而，当你希望的时候也可以选择让系统在数值溢出的时候采取截断处理，而非报错。Swift 提供的三个溢出运算符来让系统支持整数溢出运算。这些运算符都是以 & 开头的：
     1、溢出加法 &+
     2、溢出减法 &-
     3、溢出乘法 &*

     对于无符号与有符号整型数值来说，当出现上溢时，它们会从数值所能容纳的最大数变成最小数。同样地，当发生下溢时，它们会从所能容纳的最小数变成最大数。
     */
    // 数值溢出
    var unsignedOverflow = UInt8.max
    print("UInt8：\(unsignedOverflow) &+ 1 = \(unsignedOverflow &+ 1)")

    unsignedOverflow = UInt8.min
    print("UInt8：\(unsignedOverflow) &- 1 = \(unsignedOverflow &- 1)")

    var signedOverflow = Int8.max
    print("Int8：\(signedOverflow) &+ 1 = \(signedOverflow &+ 1)")

    signedOverflow = Int8.min
    print("Int8：\(signedOverflow) &- 1 = \(signedOverflow &- 1)")

}

// MARK: - 优先级和结合性
private func precedenceAndAssociativity() {
    /*
     注意：相对 C 语言和 Objective-C 来说，Swift 的运算符优先级和结合性规则更加简洁和可预测。但是，这也意味着它们相较于 C 语言及其衍生语言并不是完全一致。在对现有的代码进行移植的时候，要注意确保运算符的行为仍然符合你的预期。
     */
    print("2 + 3 % 4 * 5 = \(2 + 3 % 4 * 5)")
}

// MARK: - 运算符函数
private func operatorFunctions() {
    let vector = Vector2D(x: 3.0, y: 1.0)
    let anotherVector = Vector2D(x: 2.0, y: 4.0)
    let combinedVector = vector + anotherVector
    print("combinedVector = \(combinedVector)")


    // 前缀和后缀运算符
    let positive = Vector2D(x: 3.0, y: 4.0)
    let negative = -positive
    print("negative = \(negative)")

    let percent = positive%
    print("percent = \(percent)")


    // 复合赋值运算符
    /*
     注意：不能对默认的赋值运算符（=）进行重载。只有复合赋值运算符可以被重载。同样地，也无法对三元条件运算符 （a ? b : c） 进行重载。
     */
    var original = Vector2D(x: 1.0, y: 2.0)
    let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
    original += vectorToAdd
    print("original = \(original)")


    // 等价运算符
    /*
     如果你已经实现了“相等”运算符，通常情况下你并不需要自己再去实现“不等”运算符（!=）。标准库对于“不等”运算符提供了默认的实现，它简单地将“相等”运算符的结果进行取反后返回。
     */
    let finally = Vector2D(x: 3.0, y: 6.0)
    let isEqual = finally == original
    if isEqual {
        print("finally == original? \(isEqual)")
    } else {
        print("finally != original? \(finally != original)")
    }
}

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func +(left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

postfix operator %

extension Vector2D {
    static prefix func -(vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }

    static postfix func %(vector: Vector2D) -> Vector2D {
        return Vector2D(x: vector.x / 100, y: vector.y / 100)
    }
}

extension Vector2D {
    static func +=(left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

extension Vector2D: Equatable {
    static func ==(left: Vector2D, right: Vector2D) -> Bool {
        return left.x == right.x && left.y == right.y
    }

//    static func != (left: Vector2D, right: Vector2D) -> Bool {
//        return left.x != right.x || left.y != right.y
//    }
}

// MARK: - 自定义运算符
private func customOperators() {
    /*
     除了实现标准运算符，在 Swift 中还可以声明和实现自定义运算符。可以用来自定义运算符的字符列表请参考 运算符。
     新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符
     */
    // 自定义中缀运算符的优先级
    /*
     每个自定义中缀运算符都属于某个优先级组。优先级组指定了这个运算符相对于其他中缀运算符的优先级和结合性。优先级和结合性 中详细阐述了这两个特性是如何对中缀运算符的运算产生影响的。
     而没有明确放入某个优先级组的自定义中缀运算符将会被放到一个默认的优先级组内，其优先级高于三元运算符。

     注意：当定义前缀与后缀运算符的时候，我们并没有指定优先级。然而，如果对同一个值同时使用前缀与后缀运算符，则后缀运算符会先参与运算。
     */
    var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
    let afterDoubling = +++toBeDoubled
    print("afterDoubling = \(afterDoubling)")

    let firstVector = Vector2D(x: 1.0, y: 2.0)
    let secondVector = Vector2D(x: 3.0, y: 4.0)
    let plusMinusVector = firstVector +- secondVector
    print("plusMinusVector = \(plusMinusVector)")
}

prefix operator +++

extension Vector2D {
    static prefix func +++(vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

infix operator +-: AdditionPrecedence

extension Vector2D {
    static func +-(left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}