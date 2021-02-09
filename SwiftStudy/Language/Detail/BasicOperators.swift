//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 基本运算符：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/02_basic_operators
class BasicOperators: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")
        
        // 赋值运算符
        let b = 10
        var a = 5
        a = b
        
        let (x, y) = (1, 2)
//        if x = y {
//            // 此句错误，因为 x = y 并不返回任何值
//        }
        
        
        // 算术运算符
        var intValue = 1 + 2
        intValue = 5 - 3
        intValue = 2 * 3
        intValue = Int(10.0 / 2.5)
        
        var stringValue = "hello, " + "world"
        
        
        // 求余运算符
        intValue = 9 % 4
        intValue = -9 % 4
        intValue = 9 % -4
        
        
        // 一元运算符
        let three = 3
        let minusThree = -three
        let plusThree = -minusThree
        
        let minusSix = -6
        let alsoMinusSix = +minusSix
        
        
        // 组合赋值运算符
        a = 1
        a += 2
        
        
        // 比较运算符
        var boolValue = 1 == 1
        boolValue = 2 != 1
        boolValue = 2 > 1
        boolValue = 1 < 2
        boolValue = 1 >= 1
        boolValue = 2 <= 1
        
        let name = "world"
        if name == "world" {
            print("hello, world")
        } else {
            print("I'm sorry \(name), but I don't recognize you")
        }
        
        // true，因为 1 小于 2
        boolValue = (1, "zebra") < (2, "apple")
        // true，因为 3 等于 3，但是 apple 小于 bird
        boolValue = (3, "apple") < (3, "bird")
        // true，因为 4 等于 4，dog 等于 dog
        boolValue = (4, "dog") == (4, "dog")
        // 错误，因为 < 不能比较布尔类型
        //        boolValue = ("blue", false) < ("purple", true)
        
        
        // 三元运算符
        let contentHeight = 40
        let hasHeader = true
        let rowHeight = contentHeight + (hasHeader ? 50 : 20)
        
        
        // 空合运算符
        let c = "40"
        let d = Int(c)
        let f = d != nil ? d! : 50
        
        let defaultColorName = "red"
        // 默认值为 nil
        var userDefinedColorName: String?
        var colorNameToUse = userDefinedColorName ?? defaultColorName
        
        
        // 区间运算符
        // 闭区间运算符
        for index in 1...5 {
            print("\(index) * 5 = \(index * 5)")
        }

        let names = ["Anna", "Alex", "Brian", "Jack"]
        let count = names.count
        // 半开区间运算符
        for i in 0..<count {
            print("第 \(i + 1) 个人叫 \(names[i])")
        }

        // 单侧区间
        // 升级到 Xcode 12.4 报了：右无限 Ambiguous use of 'subscript(_:)'
//        for name in names[2...] {
//            print("右无限：\(name)")
//        }
        for name in names[...2] {
            print("左无限：\(name)")
        }
        for name in names[..<2] {
            print("左无限，最终值并不会落在区间内：\(name)")
        }

        let range = ...5
        // false
        boolValue = range.contains(7)
        // true
        boolValue = range.contains(4)
        // true
        boolValue = range.contains(-1)
        
        
        // 逻辑运算符
        let allowedEntry = false
        if !allowedEntry {
            print("ACCESS DENIED")
        }
        
        let enteredDoorCode = true
        let passedRetinaScan = false
        if enteredDoorCode && passedRetinaScan {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        
        let hasDoorKey = false
        let knowsOverridePassword = true
        if hasDoorKey || knowsOverridePassword {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        
        // 使用括号来明确优先级
        if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
    }
}
