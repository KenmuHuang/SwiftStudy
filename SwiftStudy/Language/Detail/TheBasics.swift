//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 基础部分：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/01_the_basics
class TheBasics: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        // 整数和浮点数转换
        let three = 3
        let pointOneFourOneFiveNine = 0.14159
        let pi = Double(three) + pointOneFourOneFiveNine
        
        
        // 别名
        typealias AudioSample = UInt16
        var maxAmplitudeFound = AudioSample.min
        
        
        // 布尔值
        let orangesAreOrange = true
        let turnipsAreDelicious = false
        if turnipsAreDelicious {
            print("Mmm, tasty turnips!")
        } else {
            print("Eww, turnips are horrible.")
        }
        
        
        // 元组：当遇到一些相关值的简单分组时，元组是很有用的。元组不适合用来创建复杂的数据结构。如果你的数据结构比较复杂，不要使用元组，用类或结构体去建模
        let http404Error = (404, "Not Found", "API")
        let (statusCode, message, _) = http404Error
        print("The status code is \(statusCode), message is \(message)")
        print("The status code is \(http404Error.0), message is \(http404Error.1)")
        
        let http200Status = (statusCode: 200, message: "OK")
        print("The status code is \(http200Status.statusCode), message is \(http200Status.message)")
        print("The status code is \(http200Status.0), message is \(http200Status.1)")
        
        
        // 可选类型
        let possibleNumber = "123"
        // convertedNumber 被推测为类型 "Int?"， 或者类型 "optional Int"
        var convertedNumber: Int? = Int(possibleNumber)
        convertedNumber = nil
        convertedNumber = 404
        // nil 不能用于非可选的常量和变量，如果你声明一个可选常量或者变量但是没有赋值，它们会自动被设置为 nil
        var surveyAnswer: String?
        
        // Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。
        if convertedNumber != nil {
            // 当确定可选类型确实包含值之后，可以在可选的名字后面加一个感叹号（!）来获取值。这个惊叹号表示“我知道这个可选有值，请使用它。”这被称为可选值的强制解析（forced unwrapping）
            print("convertedNumber has an integer value of \(convertedNumber!). convertedNumber = \(convertedNumber)")
        }
        
        
        // 可选绑定
        if let actualNumber = Int(possibleNumber) {
            print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
        } else {
            print("\'\(possibleNumber)\' could not be converted to an integer")
        }
        
        if let firstNumber = Int("4"),
            let secondNumber = Int("42"),
            firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
        
        if let firstNumber = Int("4") {
            if let secondNumber = Int("42") {
                if firstNumber < secondNumber && secondNumber < 100 {
                    print("\(firstNumber) < \(secondNumber) < 100")
                }
            }
        }
        
        
        // 隐式解析可选类型
        let possibleString: String? = "An optional string."
        // 需要感叹号来获取值
        let forcedString: String = possibleString!
        
        let assumedString: String! = "An implicitly unwrapped optional string."
        // 不需要感叹号
        let implicitString: String = assumedString
        
        // optionalString 的类型是 "String?"，assumedString 也没有被强制解析。
        let optionalString = assumedString
        if optionalString != nil {
            print(optionalString!)
        }
        if let definiteString = optionalString {
            print(definiteString)
        }


        /*
        // 强制执行先决条件
        let index = -2
        // 当表达式的结果为 false 的时候这条信息会被显示
        precondition(index > 0, "Index must be greater than zero.")
        fatalError("Unimplemented")


        // 断言和先决条件
        let age = -3
        let isLessThanZero = age < 0
        // 当表达式的结果为 false 的时候这条信息会被显示
        assert(isLessThanZero == false, "A person's age cannot be less than zero")
        assert(isLessThanZero)

        if isLessThanZero {
            assertionFailure("A person's age cannot be less than zero")
        }
        */
    }
}
