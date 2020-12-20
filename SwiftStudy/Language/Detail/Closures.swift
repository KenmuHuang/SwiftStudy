//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 闭包：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/07_closures
class Closures: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        // 闭包表达式
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let descendingNames = sort(names: names, isDescending: true);
        let ascendingNames = sort(names: names, isDescending: false)
        print("name = \(names), descendingNames = \(descendingNames), ascendingNames = \(ascendingNames)")


        // 尾随闭包
        someFunctionThatTakesAClosure(closure: {
            print("不使用尾随闭包进行函数调用")
        })

        someFunctionThatTakesAClosure() {
            print("使用尾随闭包进行函数调用")
        }

        someFunctionThatTakesAClosure {
            print("如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉")
        }

        let numbers = [16, 58, 510]
        print("numbers = \(numbers), translate to \(translate(numbers: numbers))")


        // 值捕获
        let incrementByTen = makeIncrementer(forIncrement: 10)
        for _ in 1..<6 {
            print("incrementByTen() = \(incrementByTen())")
        }

        let incrementBySeven = makeIncrementer(forIncrement: 7)
        for _ in 1...3 {
            print("incrementBySeven() = \(incrementBySeven())")
        }

        // 闭包是引用类型：再次调用原来的 incrementByTen 会继续增加它自己的 runningTotal 变量，该变量和 incrementBySeven 中捕获的变量没有任何联系
        print("incrementByTen() = \(incrementByTen())")
    }

    // MARK: - 闭包表达式
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }

    func forward(_ s1: String, _ s2: String) -> Bool {
        return s1 < s2
    }
    
    func sort(names: [String], isDescending: Bool) -> [String] {
        if isDescending {
//            return names.sorted(by: {(s1: String, s2: String) -> Bool in
//                return s1 > s2
//            })

            // 运算符方法
            return names.sorted(by: >)
        } else {
//            return names.sorted(by: {(s1: String, s2: String) -> Bool in
//                return s1 < s2
//            })

            // 根据上下文推断类型，单表达式闭包的隐式返回
//            return names.sorted { s1, s2 in s1 < s2 }

            // 参数名称缩写
//            return names.sorted(by: { $0 < $1 })

            // 运算符方法
//            return names.sorted(by: <)

            // 使用默认升序函数
            return names.sorted()
        }

//        return names.sorted(by: (isDescending ? backward : forward))
    }

    // MARK: - 尾随闭包
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        closure()
        print("closure() 函数之后执行")
    }

    func translate(numbers: [Int]) -> [String] {
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]

        let strings = numbers.map { number -> String in
            var output = ""

            var number = number
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0

            return output
        }
        return strings
    }

    // MARK: - 值捕获
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0

        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }

        return incrementer
    }
}