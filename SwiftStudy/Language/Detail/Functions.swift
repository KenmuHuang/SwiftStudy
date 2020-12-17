//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 函数：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/06_functions
class Functions: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        print(greet("Anna", alreadyGreeted: true))
        print(greet("Brian", alreadyGreeted: false))

        let contentCount = printAndCount(content: "Hello, world")
        if contentCount > 0 {
            printWithoutCounting(content: "Hello again, world")
            printWithoutCounting()
        }

        let arrValue = [8, -6, 2, 109, 3, 71] // []
        if let bounds = minAndMax(array: arrValue) {
            print("Min is \(bounds.min) and max is \(bounds.max) in \(arrValue)")
        }

        var average = arithmeticMean(1, 2, 3, 4, 5)
        printWithoutCounting(content: "average is \(average)")

        average = arithmeticMean(3, 8.25, 18.75)
        printWithoutCounting(content: "average is \(average)")

        var someInt = 3
        var anotherInt = 107
        printWithoutCounting(content: "SomeInt is now \(someInt), and anotherInt is now \(anotherInt).")
        swapTwoInts(&someInt, &anotherInt)
        printWithoutCounting(content: "SomeInt is now \(someInt), and anotherInt is now \(anotherInt) after executing swap operation.")

        // 使用函数类型
        var mathFunction: (Int, Int) -> Int = addTwoInts
        printWithoutCounting(content: "addTwoInts(5, 6) = \(mathFunction(5, 6))")

        mathFunction = multiplyTwoInts
        printWithoutCounting(content: "multiplyTwoInts(5, 6) = \(mathFunction(5, 6))")

        let anotherMathFunction = addTwoInts
        printWithoutCounting(content: "addTwoInts(50, 6) = \(anotherMathFunction(50, 6))")

        // 函数类型作为参数类型
        printMathResult(anotherMathFunction, 50, 6)

        // 函数类型作为返回类型
        var currentValue = 3
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
        printWithoutCounting(content: "Value move nearer to zero, origin value is \(currentValue), now value is \(moveNearerToZero(currentValue))")

        currentValue = 5
        let moveNearerToTen = chooseStepFunction(backward: currentValue > 10)
        printWithoutCounting(content: "Value move nearer to ten, origin value is \(currentValue), now value is \(moveNearerToTen(currentValue))")
    }

    ///
    /// 问候某人
    /// - Parameters:
    ///   - person: 某人
    ///   - alreadyGreeted: 是否已经问候过
    /// - Returns: 问候语
    func greet(_ person: String, alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return greetAgain(person: person, from: "Cupertino")
        } else {
            return greet(person: person, hometown: "Cupertino")
        }
    }

    private func greetAgain(person: String, from hometown: String) -> String {
//        return "Hello again, \(person)!"

        // 隐式返回的函数
        "Hello again, \(person)! Glad you could visit from \(hometown)."
    }

    private func greet(person: String, hometown: String) -> String {
//        let greeting = "Hello, " + person + "!"
        let greeting = "Hello, \(person)! Glad you could visit from \(hometown)."
        return greeting
    }

    ///
    /// 有计数的打印
    /// - Parameter content: 打印内容
    /// - Returns: 内容字符个数
    func printAndCount(content: String) -> Int {
        print(content)
        return content.count
    }

    ///
    /// 没有计数的打印
    /// - Parameter content: 打印内容
    func printWithoutCounting(content: String = "Hello, IT.") {
        let _ = printAndCount(content: content)
    }

    ///
    ///  查询数字数组中的最小值和最大值
    /// - Parameter array: 数字数组
    /// - Returns: 数字数组中的最小值和最大值
    func minAndMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty {
            return nil
        }

        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }

    ///
    /// 计算一组任意长度数字的算术平均数
    /// - Parameter numbers: 一组任意长度数字
    /// - Returns: 算术平均数
    func arithmeticMean(_ numbers: Double...) -> Double {
        // 一个函数最多只能拥有一个可变参数
        var total = 0.0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }

    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        // 输入输出参数不能有默认值，而且可变参数不能用 inout 标记
        let temporaryA = a
        a = b
        b = temporaryA
    }

    // MARK: - 函数类型作为参数类型
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
        return a * b
    }

    func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFunction(a, b))")
    }

    // MARK: - 函数类型作为返回类型
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        // 嵌套函数
        func stepForward(_ input: Int) -> Int {
            return input + 1
        }

        func stepBackward(_ input: Int) -> Int {
            return input - 1
        }

        return backward ? stepBackward : stepForward
    }
}