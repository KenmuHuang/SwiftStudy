//
//  Function.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2020/6/7.
//  Copyright © 2020 KenmuHuang. All rights reserved.
//

import UIKit

class Function: NSObject {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        print(greet(person: "Bob", day: "Tuesday"))
        print(greet("John", on: "Wednesday"))

        var numbers = [5, 3, 100, 3, 9]
        let statistics = calculateStatistics(scores: numbers)
        print("numbers: \(numbers), min: \(statistics.min), max: \(statistics.max), sum: \(statistics.sum)")
        print("numbers: \(numbers), min: \(statistics.0), max: \(statistics.1), sum: \(statistics.2)")

        print("returnFifteen: \(returnFifteen())")

        let increment = makeIncrementer()
        print("increment: \(increment(7))")

        numbers = [20, 19, 7, 12]
        let matches = hasAnyMatches(list: numbers, condition: lessThanTen)
        print("numbers: \(numbers) lessThanTen, isMatch: \(matches.isMatch), matchNumber: \(matches.matchNumber)")

        print("closureDoubleNumbers: \(closureDoubleNumbers(numbers: numbers))")

        print("sortedNumbers: \(sortedNumbers(numbers: numbers))")
    }

    /// 使用参数标签的方法
    func greet(person: String, day: String) -> String {
        return "Hello \(person), today is \(day)."
    }

    /// 不使用参数标签的方法
    func greet(_ person: String, on day: String) -> String {
        return greet(person: person, day: day)
    }

    /// 返回多个值的方法
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0

        for score in scores {
            if score > max {
                max = score
            } else if score < min {
                min = score
            }
            sum += score
        }

        return (min, max, sum)
    }

    /// 内嵌方法
    func returnFifteen() -> Int {
        var y = 10

        func add() {
            y += 5
        }
        add()

        return y
    }

    /// 返回方法的方法
    func makeIncrementer() -> (Int) -> Int {
        func addOne(number: Int) -> Int {
            return 1 + number
        }

        return addOne
    }

    func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> (isMatch: Bool, matchNumber: Int) {
        for item in list {
            if condition(item) {
                return (true, item)
            }
        }
        return (false, 0)
    }

    func lessThanTen(number: Int) -> Bool {
        return number < 10
    }

    /// 闭包方法
    func closureDoubleNumbers(numbers: [Int]) -> [Int] {
        var mappedNumbers = numbers.map({ (number: Int) -> Int in
            let result = 2 * number
            return result
        })

        // 简化闭包
        mappedNumbers = numbers.map({ number in 2 * number })
        return mappedNumbers
    }

    /// 通过数字而非名称来引用参数，简化闭包方法
    func sortedNumbers(numbers: [Int]) -> [Int] {
        var mappedNumbers = numbers.sorted(by: {(obj1, obj2) -> Bool in
            return obj1 < obj2
        })

        // 简化闭包
        mappedNumbers = numbers.sorted{ $0 < $1 }
        return mappedNumbers
    }
}
