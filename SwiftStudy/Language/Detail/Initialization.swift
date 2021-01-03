//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 构造过程：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/14_initialization
class Initialization: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        settingInitialValuesForStoredProperties()
        customizingInitialization()
        defaultInitializers()
        initializerDelegationForValueTypes()
        classInheritanceAndInitialization()
        failableInitializers()
        requiredInitializers()
        settingADefaultPropertyValueWithAClosureFunction()
    }

    // MARK: - 存储属性的初始赋值
    private func settingInitialValuesForStoredProperties() {
        // 构造器
        let fahrenheit = Fahrenheit()
        // 打印：32.0
        print(fahrenheit.temperature)


        // 默认属性值
        var fahrenheit2 = Fahrenheit2()
        // 打印：1.0
        print(fahrenheit2.temperature)

        fahrenheit2 = Fahrenheit2(temperature: 21.0)
        // 打印：21.0
        print(fahrenheit2.temperature)
    }

    ///
    /// 华氏温度的结构体
    struct Fahrenheit {
        var temperature: Double

        init() {
            temperature = 32.0
        }
    }

    struct Fahrenheit2 {
        var temperature: Double = 1.0
    }

    // MARK: - 自定义构造过程
    private func customizingInitialization() {
        // 形参的构造过程
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        print(boilingPointOfWater.temperatureInCelsius)

        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        print(freezingPointOfWater.temperatureInCelsius)


        // 形参命名和实参标签
        var halfGray = Color(white: 0.5)
        print(halfGray)

        var magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        print(magenta)


        // 不带实参标签的构造器形参
        halfGray = Color(0.5)
        print(halfGray)

        magenta = Color(1.0, 0.0, 1.0)
        print(magenta)


        // 可选属性类型
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        if cheeseQuestion.response == nil {
            cheeseQuestion.response = "Yes, I do like cheese."
            cheeseQuestion.answer()
        }

        // 构造过程中常量属性的赋值
        let beetsQuestion = SurveyQuestion(text: "How about beets?")
        beetsQuestion.ask()
    }

    struct Celsius {
        var temperatureInCelsius: Double
        init(fromFahrenheit fahrenheit: Double) {
            temperatureInCelsius = (fahrenheit - 32.0) / 1.8
        }
        init(fromKelvin kelvin: Double) {
            temperatureInCelsius = kelvin - 273.15
        }
    }

    struct Color {
        let red, green, blue: Double

        init(white: Double) {
            red = white
            green = white
            blue = white
        }

        init(_ white: Double) {
            red = white
            green = white
            blue = white
        }

        init(red: Double, green: Double, blue: Double) {
            self.red = red
            self.green = green
            self.blue = blue
        }

        init(_ red: Double, _ green: Double, _ blue: Double) {
            self.red = red
            self.green = green
            self.blue = blue
        }
    }

    class SurveyQuestion {
        let text: String
        var response: String?

        init(text: String) {
            self.text = text
        }

        func ask() {
            print(text)
        }

        func answer() {
            print(response!)
        }
    }

    // MARK: - 默认构造器
    private func defaultInitializers() {
        // 结构体的逐一成员构造器
        let zeroByTwo = Size(height: 2.0)
        print(zeroByTwo.width, zeroByTwo.height)

        let zeroByZero = Size()
        print(zeroByZero.width, zeroByZero.height)
    }

    class ShoppingListItem {
        var name: String?
        var quantity = 1
        var purchased = false
    }

    struct Size {
        var width = 0.0, height = 0.0
    }

    // MARK: - 值类型的构造器代理
    private func initializerDelegationForValueTypes() {
        /*
         注意：假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。
         */
        let basicRect = Rect()
        print("basicRect = \(basicRect)")

        let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
        print("originRect = \(originRect)")

        let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
            size: Size(width: 3.0, height: 3.0))
        print("centerRect = \(centerRect)")
    }

    struct Point {
        var x = 0.0, y = 0.0
    }

    struct Rect {
        var origin = Point()
        var size = Size()

        init() {

        }

        init(origin: Point, size: Size) {
            self.origin = origin
            self.size = size
        }

        init(center: Point, size: Size) {
            let originX = center.x - size.width / 2
            let originY = center.y - size.height / 2
            self.init(origin: Point(x: originX, y: originY), size: size)
        }
    }

    // MARK: - 类的继承和构造过程
    private func classInheritanceAndInitialization() {
        // 指定构造器和便利构造器


        // 指定构造器和便利构造器的语法


        // 类类型的构造器代理


        // 两段式构造过程


        // 构造器的继承和重写


        // 构造器的自动继承


        // 指定构造器和便利构造器实践

    }

    // MARK: - 可失败构造器
    private func failableInitializers() {
        // 枚举类型的可失败构造器


        // 带原始值的枚举类型的可失败构造器


        // 构造失败的传递


        // 重写一个可失败构造器


        // init! 可失败构造器

    }

    // MARK: - 必要构造器
    private func requiredInitializers() {

    }

    // MARK: - 通过闭包或函数设置属性的默认值
    private func settingADefaultPropertyValueWithAClosureFunction() {

    }
}