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
        /*
         类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。

         Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们被称为指定构造器和便利构造器。
         */


        // 指定构造器和便利构造器的语法
        /*
         init(parameters) {
            statements
         }

         convenience init(parameters) {
            statements
         }
         */


        // 类类型的构造器代理
        /*
         为了简化指定构造器和便利构造器之间的调用关系，Swift 构造器之间的代理调用遵循以下三条规则：

         规则 1
         指定构造器必须调用其直接父类的的指定构造器。

         规则 2
         便利构造器必须调用同类中定义的其它构造器。

         规则 3
         便利构造器最后必须调用指定构造器。

         一个更方便记忆的方法是：
         1、指定构造器必须总是向上代理
         2、便利构造器必须总是横向代理
         */


        // 两段式构造过程
        /*
         Swift 中类的构造过程包含两个阶段。第一个阶段，类中的每个存储型属性赋一个初始值。当每个存储型属性的初始值被赋值后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步自定义它们的存储型属性。

         两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。

         注意：Swift 的两段式构造过程跟 Objective-C 中的构造过程类似。最主要的区别在于阶段 1，Objective-C 给每一个属性赋值 0 或空值（比如说 0 或 nil）。Swift 的构造流程则更加灵活，它允许你设置定制的初始值，并自如应对某些属性不能以 0 或 nil 作为合法默认值的情况。

         阶段 1
         类的某个指定构造器或便利构造器被调用。
         完成类的新实例内存的分配，但此时内存还没有被初始化。
         指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
         指定构造器切换到父类的构造器，对其存储属性完成相同的任务。
         这个过程沿着类的继承链一直往上执行，直到到达继承链的最顶部。
         当到达了继承链最顶部，而且继承链的最后一个类已确保所有的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。

         阶段 2
         从继承链顶部往下，继承链中每个类的指定构造器都有机会进一步自定义实例。构造器此时可以访问 self、修改它的属性并调用实例方法等等。
         最终，继承链中任意的便利构造器有机会自定义实例和使用 self。
         */

        // 构造器的继承和重写
        /*
         跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，而在用来创建子类时的新实例时没有完全或错误被初始化。

         注意：当你重写一个父类的指定构造器时，你总是需要写 override 修饰符，即使是为了实现子类的便利构造器。
         相反，如果你编写了一个和父类便利构造器相匹配的子类构造器，由于子类不能直接调用父类的便利构造器，因此，严格意义上来讲，你的子类并未对一个父类构造器提供重写。最后的结果就是，你在子类中“重写”一个父类便利构造器时，不需要加 override 修饰符。

         注意：子类可以在构造过程修改继承来的变量属性，但是不能修改继承来的常量属性。
         */
        let vehicle = Vehicle()
        print("Vehicle: \(vehicle.description)")

        let bicycle = Bicycle()
        print("Bicycle: \(bicycle.description)")

        let hoverboard = Hoverboard(color: "silver")
        print("Hoverboard: \(hoverboard.description)")


        // 构造器的自动继承
        /*
         如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的。事实上，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。
         假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则将适用：

         规则 1
         如果子类没有定义任何指定构造器，它将自动继承父类所有的指定构造器。

         规则 2
         如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承父类所有的便利构造器。

         即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。

         注意：子类可以将父类的指定构造器实现为便利构造器来满足规则 2。
         */


        // 指定构造器和便利构造器实践
        var namedMeat = Food()
        print(namedMeat.name)

        namedMeat = Food(name: "Bacon")
        print(namedMeat.name)

        let oneMysteryItem = RecipeIngredient()
        print(oneMysteryItem.name, oneMysteryItem.quantity)

        let oneBacon = RecipeIngredient(name: "Bacon")
        print(oneBacon.name, oneBacon.quantity)

        let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        print(sixEggs.name, sixEggs.quantity)

        var breakfastList = [
            ShoppingListItem(),
            ShoppingListItem(name: "Bacon"),
            ShoppingListItem(name: "Eggs", quantity: 6),
        ]
        breakfastList[0].name = "Orange juice"
        breakfastList[0].purchased = true
        for item in breakfastList {
            print(item.description)
        }
    }

    class Vehicle {
        var numberOfWheels = 0
        var description: String {
            return "\(numberOfWheels) wheel(s)"
        }
    }

    class Bicycle: Vehicle {
        override init() {
            super.init()

            numberOfWheels = 2
        }
    }

    class Hoverboard: Vehicle {
        var color: String
        init(color: String) {
            self.color = color

            // super.init() 在这里被隐式调用
        }
        override var description: String {
            return "\(super.description) in a beautiful \(color)"
        }
    }

    class Food {
        var name: String

        init(name: String) {
            self.name = name
        }

        convenience init() {
            self.init(name: "[Unnamed]")
        }
    }

    class RecipeIngredient: Food {
        var quantity: Int

        init(name: String, quantity: Int) {
            self.quantity = quantity

            super.init(name: name)
        }

        override convenience init(name: String) {
            self.init(name: name, quantity: 1)
        }
    }

    class ShoppingListItem: RecipeIngredient {
        var purchased = false
        var description: String {
            var output = "\(quantity) x \(name) "
            output += purchased ? "✔" : "✘"
            return output
        }
    }

    // MARK: - 可失败构造器
    private func failableInitializers() {
        /*
         注意：检查空字符串的值（如 ""，而不是 "Giraffe" ）和检查值为 nil 的可选类型的字符串是两个完全不同的概念。上例中的空字符串（""）其实是一个有效的，非可选类型的字符串。这里我们之所以让 Animal 的可失败构造器构造失败，只是因为对于 Animal 这个类的 species 属性来说，它更适合有一个具体的值，而不是空字符串。
         */
        let someCreature = Animal(species: "Giraffe")
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }

        let anonymousCreature = Animal(species: "")
        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }

        // 枚举类型的可失败构造器
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }

        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }


        // 带原始值的枚举类型的可失败构造器
        /*
         带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:)，该可失败构造器有一个合适的原始值类型的 rawValue 形参，选择找到的相匹配的枚举成员，找不到则构造失败。
         */
        let fahrenheitUnitByMoreSimple = TemperatureUnitByMoreSimple(rawValue: "F")
        if fahrenheitUnitByMoreSimple != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }

        let unknownUnitByMoreSimple = TemperatureUnitByMoreSimple(rawValue: "X")
        if unknownUnitByMoreSimple == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }

        // 构造失败的传递
        /*
         类、结构体、枚举的可失败构造器可以横向代理到它们自己其他的可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。
         无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。

         注意：可失败构造器也可以代理到其它的不可失败构造器。通过这种方式，你可以增加一个可能的失败状态到现有的构造过程中。
         */
        if let twoSocks = CartItem(name: "sock", quantity: 2) {
            print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
        }

        if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
            print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
        } else {
            print("Unable to initialize zero shirts")
        }

        if let oneUnnamed = CartItem(name: "", quantity: 1) {
            print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
        } else {
            print("Unable to initialize one unnamed product")
        }

        // 重写一个可失败构造器
        let automaticallyNamedDocument = AutomaticallyNamedDocument()
        print(automaticallyNamedDocument.name!)

        let untitledDocument = UntitledDocument()
        print(untitledDocument.name!)


        // init! 可失败构造器
        /*
         通常来说我们通过在 init 关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在 init 后面添加感叹号的方式来定义一个可失败构造器（init!），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。

         你可以在 init? 中代理到 init!，反之亦然。你也可以用 init? 重写 init!，反之亦然。你还可以用 init 代理到 init!，不过，一旦 init! 构造失败，则会触发一个断言。
         */
    }

    struct Animal {
        let species: String

        init?(species: String) {
            if species.isEmpty {
                return nil
            }

            self.species = species
        }
    }

    enum TemperatureUnit {
        case Kelvin, Celsius, Fahrenheit
        init?(symbol: Character) {
            switch symbol {
            case "K":
                self = .Kelvin
            case "C":
                self = .Celsius
            case "F":
                self = .Fahrenheit
            default:
                return nil
            }
        }
    }

    enum TemperatureUnitByMoreSimple: Character {
        case Kelvin = "K"
        case Celsius = "C"
        case Fahrenheit = "F"
    }

    class Product {
        let name: String
        init?(name: String) {
            if name.isEmpty {
                return nil
            }

            self.name = name
        }
    }

    class CartItem: Product {
        let quantity: Int
        init?(name: String, quantity: Int) {
            if quantity < 1 {
                return nil
            }

            self.quantity = quantity

            super.init(name: name)
        }
    }

    class Document {
        var name: String?

        init() {

        }

        init?(name: String) {
            if name.isEmpty {
                return nil
            }

            self.name = name
        }
    }

    class AutomaticallyNamedDocument: Document {
        override init() {
            super.init()

            self.name = "[Untitled]"
        }

        override init(name: String) {
            super.init()

            if name.isEmpty {
                self.name = "[Untitled]"
            } else {
                self.name = name
            }
        }
    }

    class UntitledDocument: Document {
        override init() {
            super.init(name: "[Untitled]")!
        }
    }

    // MARK: - 必要构造器
    private func requiredInitializers() {

    }

    // MARK: - 通过闭包或函数设置属性的默认值
    private func settingADefaultPropertyValueWithAClosureFunction() {

    }
}