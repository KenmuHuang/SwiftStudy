//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 协议：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/21_protocols
class Protocols: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        protocolSyntax()
        propertyRequirements()
        methodRequirements()
        mutatingMethodRequirements()
        initializerRequirements()
        protocolsAsTypes()
        delegation()
        addingProtocolConformanceWithAnExtension()
        conditionallyConformingToAProtocol()
        declaringProtocolAdoptionWithAnExtension()
        adoptingAProtocolUsingASynthesizedImplementation()
        collectionsOfProtocolTypes()
        protocolInheritance()
        classOnlyProtocol()
        protocolComposition()
        checkingForProtocolConformance()
        optionalProtocolRequirements()
        protocolExtensions()
    }
}

// MARK: - 协议语法
private func protocolSyntax() {
    let someClass = SomeClass(someProperty: "Hello world.")
    someClass.printSomeProperty()
}

protocol FirstProtocol {

}

protocol AnotherProtocol {

}

struct SomeStructure: FirstProtocol, AnotherProtocol {

}

class SomeSuperClass {
    var someProperty: String

    init(someProperty: String) {
        self.someProperty = someProperty
    }
}

class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
    internal func printSomeProperty() {
        print("The someProperty is \(someProperty)")
    }
}

// MARK: - 属性要求
private func propertyRequirements() {
    let person = Person(fullName: "John")
    print("The person.fullName is \(person.fullName)")

    let starship = Starship(prefix: "USS", name: "Enterprise")
    print("The starship.fullName is = \(starship.fullName)")
}

protocol FullyNamed {
    static var someTypeProperty: Int { get set }
    var fullName: String { get }
}

struct Person: FullyNamed {
    static var someTypeProperty: Int = 0
    private(set) var fullName: String = ""
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    static var someTypeProperty: Int {
        get {
            100
        }
        set {

        }
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }

    init(prefix: String?, name: String) {
        self.prefix = prefix
        self.name = name
    }
}

// MARK: - 方法要求
private func methodRequirements() {
    let generator = LinearCongruentialGenerator()
    print("Here's a random number: \(generator.random())")
    print("And another one: \(generator.random())")
}

protocol RandomNumberGenerator {
    static func typeRandom() -> Double
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0

    static func typeRandom() -> Double {
        return 0.0
    }

    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

// MARK: - 异变方法要求
private func mutatingMethodRequirements() {
    var lightSwitch = OnOffSwitch.off
    lightSwitch.toggle()
    print("The lightSwitch is \(lightSwitch)")
}

protocol Toggleable {
    /*
     如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。
     注意：实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。
     */
    mutating func toggle()
}

enum OnOffSwitch: Toggleable {
    case off, on

    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off

        }
    }
}

// MARK: - 构造器要求
private func initializerRequirements() {
    // 协议构造器要求的类实现
    _ = OtherSomeClass(someParameter: 4)
    _ = OtherSomeSubClass(someParameter: 12)

    // 可失败构造器要求
    /*
     遵循协议的类型可以通过可失败构造器（init?）或非可失败构造器（init）来满足协议中定义的可失败构造器要求。协议中定义的非可失败构造器要求可以通过非可失败构造器（init）或隐式解包可失败构造器（init!）来满足。
     */
}

protocol SomeProtocol {
    init(someParameter: Int)
}

class OtherSomeClass: SomeProtocol {
    required init(someParameter: Int) {
        print("OtherSomeClass initial with parameter of \(someParameter).")
    }
}

class OtherSomeSuperClass {
    init(someParameter: Int) {
        print("OtherSomeSuperClass initial with parameter of \(someParameter).")
    }
}

class OtherSomeSubClass: OtherSomeSuperClass, SomeProtocol {
    // 因为遵循协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init(someParameter: Int) {
        super.init(someParameter: someParameter)

        print("OtherSomeSubClass initial with parameter of \(someParameter).")
    }
}

// MARK: - 协议作为类型
private func protocolsAsTypes() {
    var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
    for _ in 1...5 {
        print("Random dice roll is \(d6.roll())")
    }
}

class Dice {
    /*
     协议可以像其他普通类型一样使用，使用场景如下：
     1、作为函数、方法或构造器中的参数类型或返回值类型
     2、作为常量、变量或属性的类型
     3、作为数组、字典或其他容器中的元素类型

     注意：协议是一种类型，因此协议类型的名称应与其他类型（例如 Int，Double，String）的写法相同，使用大写字母开头的驼峰式写法，例如（FullyNamed 和 RandomNumberGenerator）。
     */
    let sides: Int
    let generator: RandomNumberGenerator

    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }

    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

// MARK: - 委托
private func delegation() {
    let tracker = DiceGameTracker()
    let game = SnakesAndLadders()
    game.delegate = tracker
    game.play()
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    var delegate: DiceGameDelegate?

    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }

    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0

    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }

    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }

    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }


}

// MARK: - 在扩展里添加协议遵循
private func addingProtocolConformanceWithAnExtension() {
    let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
    print(d12.textualDescription)

    let game = SnakesAndLadders()
    print(game.textualDescription)
}

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    /*
     注意：通过扩展令已有类型遵循并符合协议时，该类型的所有实例也会随之获得协议中定义的各项功能。
     */
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

// MARK: - 有条件地遵循协议
private func conditionallyConformingToAProtocol() {
    let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
    let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
    let diceList = [d6, d12]
    print(diceList.textualDescription)

    // 由于数组元素不满足继承 TextRepresentable 条件，所以没有 textualDescription 只读属性
//    let nameList = ["john", "tom"]
//    print(nameList.textualDescription)
}

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
//        let itemAsText = self.map {
//            $0.textualDescription
//        }
        // Passing key paths as functions: https://www.swiftbysundell.com/tips/passing-key-paths-as-functions/
        let itemAsText = self.map(
            \.textualDescription
        )
        return "[\(itemAsText.joined(separator: ", "))]"
    }
}

// MARK: - 在扩展里声明采纳协议
private func declaringProtocolAdoptionWithAnExtension() {
    let simonTheHamster = Hamster(name: "Simon")
    let somethingTextRepresentable: TextRepresentable = simonTheHamster
    print(somethingTextRepresentable.textualDescription)
}

struct Hamster {
    /*
     注意：即使满足了协议的所有要求，类型也不会自动遵循协议，必须显式地遵循协议。
     */
    var name: String

    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {
}

// MARK: - 使用合成实现来采纳协议
private func adoptingAProtocolUsingASynthesizedImplementation() {
    let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
    let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
    if twoThreeFour == anotherTwoThreeFour {
        print("These two vectors are also equivalent.")
    }

    var levels = [
        SkillLevel.intermediate,
        SkillLevel.beginner,
        SkillLevel.expert(stars: 5),
        SkillLevel.expert(stars: 3)
    ]
    for level in levels.sorted() {
        print(level)
    }
}

struct Vector3D: Equatable {
    /*
     Swift 为以下几种自定义类型提供了 Equatable 协议的合成实现：
     1、遵循 Equatable 协议且只有存储属性的结构体
     2、遵循 Equatable 协议且只有关联类型的枚举
     3、没有任何关联类型的枚举

     Swift 为以下几种自定义类型提供了 Hashable 协议的合成实现：
     1、遵循 Hashable 协议且只有存储属性的结构体
     2、遵循 Hashable 协议且只有关联类型的枚举
     3、没有任何关联类型的枚举

     Swift 为没有原始值的枚举类型提供了 Comparable 协议的合成实现。如果枚举类型包含关联类型，那这些关联类型也必须同时遵循 Comparable 协议。在包含原始枚举类型声明的文件中声明其对 Comparable 协议的遵循，可以得到 < 操作符的合成实现，且无需自己编写任何关于 < 的实现代码。Comparable 协议同时包含 <=、> 和 >= 操作符的默认实现。
     */
    var x = 0.0, y = 0.0, z = 0.0
}

enum SkillLevel: Comparable {
    /// 初学者
    case beginner
    /// 中级
    case intermediate
    /// 专家
    case expert(stars: Int)
}

// MARK: - 协议类型的集合
private func collectionsOfProtocolTypes() {
    let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
    let simonTheHamster = Hamster(name: "Simon")
    let things: [TextRepresentable] = [d6, simonTheHamster]
    for thing in things {
        print(thing.textualDescription)
    }
}

// MARK: - 协议的继承
private func protocolInheritance() {
    let game = SnakesAndLadders()
    print(game.prettyTextualDescription)
}

protocol PrettyTextRepresentable: TextRepresentable {
    /*
     协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔
     */
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

// MARK: - 类专属的协议
private func classOnlyProtocol() {
    print(SomeSpecialClass().textualDescription)
}

protocol SomeClassOnlyProtocol: AnyObject, TextRepresentable {
    /*
     你通过添加 AnyObject 关键字到协议的继承列表，就可以限制协议只能被类类型采纳（以及非结构体或者非枚举的类型）。

     注意：当协议定义的要求需要遵循协议的类型必须是引用语义而非值语义时，应该采用类类型专属协议。关于引用语义和值语义的更多内容，请查看 结构体和枚举是值类型 和 类是引用类型。
     */
}

class SomeSpecialClass: SomeClassOnlyProtocol {
    var textualDescription: String {
        return "Add AnyObject sign to become only inherited for class."
    }
}

// MARK: - 协议合成
private func protocolComposition() {
    let birthdayPerson = Human(name: "Malcolm", age: 21)
    wishHappyBirthday(to: birthdayPerson)

    let seattle = City(longitude: -122.3, latitude: 47.6, name: "Seattle")
    beginConcert(in: seattle)

    // 缺少 Location 类型，会报错：error: cannot convert value of type 'Human' to expected argument type 'Location'
//    beginConcert(in: birthdayPerson)
}

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Human: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

class Location {
    /// 经度
    var longitude: Double
    /// 纬度
    var latitude: Double

    init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}

class City: Location, Named {
    var name: String

    init(longitude: Double, latitude: Double, name: String) {
        self.name = name
        super.init(longitude: longitude, latitude: latitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name), the location is (\(location.longitude), \(location.latitude))")
}

// MARK: - 检查协议一致性
private func checkingForProtocolConformance() {
    /*
     1、is 用来检查实例是否遵循某个协议，若遵循则返回 true，否则返回 false；
     2、as? 返回一个可选值，当实例遵循某个协议时，返回类型为协议类型的可选值，否则返回 nil；
     3、as! 将实例强制向下转换到某个协议类型，如果强转失败，将触发运行时错误。
     */
//    let objects = [
//        Circle(radius: 2.0),
//        Country(area: 243_610),
//        Animal(legs: 4)
//    ] as [Any]

    let objects: [AnyObject] = [
        Circle(radius: 2.0),
        Country(area: 243_610),
        Animal(legs: 4)
    ]

    for object in objects {
//        if object is HasArea {
//            let objectWithArea = object as! HasArea
//            print("Area is \(objectWithArea.area)")
//        } else {
//            print("Something that doesn't have an area")
//        }

        if let objectWithArea = object as? HasArea {
            print("Area is \(objectWithArea.area)")
        } else {
            print("Something that doesn't have an area")
        }
    }
}

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double {
        return pi * pow(radius, 2)
    }

    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double

    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int

    init(legs: Int) {
        self.legs = legs
    }
}

// MARK: - 可选的协议要求
private func optionalProtocolRequirements() {
    /*
     协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
     使用可选要求时（例如，可选的方法或者属性），它们的类型会自动变成可选的。比如，一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
     */
    let counter = Counter()
    counter.dataSource = ThreeSource()
    for _ in 1...4 {
        counter.increment()
        print(counter.count)
    }

    counter.count = -4
    counter.dataSource = TowardsZeroSource()
    for _ in 1...5 {
        counter.increment()
        print(counter.count)
    }
}

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?

    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

// MARK: - 协议扩展
private func protocolExtensions() {
    let generator = LinearCongruentialGenerator()
    print("Here's a random number: \(generator.random())")
    print("And here's a random Boolean: \(generator.randomBool())")

    // 提供默认实现
    let game = SnakesAndLadders()
    print(game.textualDescription)
    print(game.defaultTextualDescription)

    //为协议扩展添加限制条件
    let equalNumbers = [100, 100, 100, 100, 100]
    print(equalNumbers.allEqual())

    let differentNumbers = [100, 100, 200, 100, 200]
    print(differentNumbers.allEqual())
}

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

extension PrettyTextRepresentable {
    /*
     注意：通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。
     */
    var defaultTextualDescription: String {
        return "*\(textualDescription)*"
    }
}

extension Collection where Element: Equatable {
    /*
     在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述，正如 泛型 Where 子句 中所描述的。

     例如，你可以扩展 Collection 协议，适用于集合中的元素遵循了 Equatable 协议的情况。通过限制集合元素遵循 Equatable 协议， 作为标准库的一部分， 你可以使用 == 和 != 操作符来检查两个元素的等价性和非等价性。

     注意：如果一个遵循的类型满足了为同一方法或属性提供实现的多个限制型扩展的要求， Swift 会使用最匹配限制的实现。
     */
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}