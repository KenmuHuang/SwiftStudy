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

        print(greet(person: "Anna", alreadyGreeted: true))
        print(greet(person: "Brian", alreadyGreeted: false))

        let contentCount = printAndCount(content: "Hello, world")
        if contentCount > 0 {
            printWithoutCounting(content: "Hello again, world")
        }

        let arrValue = [8, -6, 2, 109, 3, 71] // []
        if let bounds = minAndMax(array: arrValue) {
            print("Min is \(bounds.min) and max is \(bounds.max) in \(arrValue)")
        }
    }

    ///
    /// 问候某人
    /// - Parameters:
    ///   - person: 某人
    ///   - alreadyGreeted: 是否已经问候过
    /// - Returns: 问候语
    func greet(person: String, alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return greetAgain(person: person)
        } else {
            return greet(person: person)
        }
    }

    private func greetAgain(person: String) -> String {
//        return "Hello again, \(person)!"

        // 隐式返回的函数
        "Hello again, \(person)!"
    }

    private func greet(person: String) -> String {
//        let greeting = "Hello, " + person + "!"
        let greeting = "Hello, \(person)!"
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
    func printWithoutCounting(content: String) {
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
}