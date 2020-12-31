//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 属性：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/10_properties
class Properties: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        storedProperties()
        computedProperties()
        propertyObservers()
        propertyWrappers()
        typeProperties()
    }

    // MARK: - 存储属性
    private func storedProperties() {
        // 常量结构体实例的存储属性
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        rangeOfThreeItems.firstValue = 6

        let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
        // 尽管 firstValue 是个可变属性，但这里还是会报错。由于结构体属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量
//        rangeOfFourItems.firstValue = 6


        // 延时加载存储属性
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")

        // lazy 不能用于 let 常量是因为它要初始化就赋值。由于使用了 lazy，DataImporter 的实例 importer 属性只有在第一次被访问的时候才被创建。比如访问它的属性 fileName 时：
        print(manager.importer.fileName)


        // 存储属性和实例变量
        // Swift 中的属性没有对应的实例变量，属性的备份存储也无法直接访问。这就避免了不同场景下访问方式的困扰，同时也将属性的定义简化成一个语句。属性的全部信息——包括命名、类型和内存管理特征——作为类型定义的一部分，都定义在一个地方。
    }

    ///
    /// 描述整数的区间，且这个范围值在被创建后不能被修改。
    struct FixedLengthRange {
        var firstValue: Int
        let length: Int
    }

    ///
    /// DataImporter 是一个负责将外部文件中的数据导入的类。这个类的初始化会消耗不少时间。
    class DataImporter {
        var fileName = "data.txt"

        // 这里会提供数据导入功能
    }

    class DataManager {
        lazy var importer = DataImporter()
        var data = [String]()

        // 这里会提供数据管理功能
    }
    
    // MARK: - 计算属性
    private func computedProperties() {
        // 简化 Setter 声明
        var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        print("initialSquareCenter is at \(initialSquareCenter)")
        print("square.center is at \(square.center)")


        // 简化 Getter 声明
        square.center = Point(x: 15.0, y: 15.0)
        print("initialSquareCenter is now at \(initialSquareCenter)")
        print("square.center is now at \(square.center)")
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")


        // 只读计算属性
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

        // 由于是只读，所以不能赋值，会报错
//        fourByFiveByTwo.volume = 20.0
    }

    struct Point {
        var x = 0.0, y = 0.0
    }

    struct Size {
        var width = 0.0, height = 0.0
    }

    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {
//            get {
//                let centerX = origin.x + (size.width / 2)
//                let centerY = origin.y + (size.height / 2)
//                return Point(x: centerX, y: centerY)
//            }
            // 简化 Getter 声明：如果整个 getter 是单一表达式，getter 会隐式地返回这个表达式结果
            get {
                Point(x: origin.x + (size.width / 2),
                      y: origin.y + (size.height / 2))
            }
//            set(newCenter) {
//                origin.x = newCenter.x - (size.width / 2)
//                origin.y = newCenter.y - (size.height / 2)
//            }
            // 简化 Setter 声明：如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称 newValue
            set {
                origin.x = newValue.x - (size.width / 2)
                origin.y = newValue.y - (size.height / 2)
            }
        }
    }

    ///
    /// 三维空间的立方体结构
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double {
            return width * height * depth
        }
    }

    // MARK: - 属性观察器
    private func propertyObservers() {
        let stepCounter = StepCounter()

        // 打印：将 totalSteps 的值设置为 200
        // 打印：增加了 200 步
        stepCounter.totalSteps = 200

        // 打印：将 totalSteps 的值设置为 360
        // 打印：增加了 160 步
        stepCounter.totalSteps = 360

        // 打印：将 totalSteps 的值设置为 896
        // 打印：增加了 536 步
        stepCounter.totalSteps = 896
    }

    ///
    /// 步行时的总步数类
    class StepCounter {
        /*
         你可以在以下位置添加属性观察器：
          1、自定义的存储属性
          2、继承的存储属性
          3、继承的计算属性

         可以为属性添加其中一个或两个观察器：
          willSet 在新的值被设置之前调用
          didSet 在新的值被设置之后调用
         */
        var totalSteps: Int = 0 {
//            willSet(newTotalSteps) {
//                print("将 totalSteps 的值设置为 \(newTotalSteps)")
//            }
            willSet {
                print("将 totalSteps 的值设置为 \(newValue)")
            }
//            didSet(oldTotalSteps) {
//                if totalSteps > oldTotalSteps {
//                    print("增加了 \(totalSteps - oldTotalSteps) 步")
//                }
//            }
            didSet {
                if totalSteps > oldValue {
                    print("增加了 \(totalSteps - oldValue) 步")
                }
            }
        }
    }

    // MARK: - 属性包装器
    private func propertyWrappers() {
        var smallRectangle = SmallRectangle()
        // 打印：0
        print(smallRectangle.height)

        smallRectangle.height = 10
        // 打印：10
        print(smallRectangle.height)

        smallRectangle.height = 24
        // 打印：12
        print(smallRectangle.height)


        // 设置被包装属性的初始值
        var zeroRectangle = ZeroRectangle()
        // 打印：0 0
        print(zeroRectangle.width, zeroRectangle.height)

        let unitRectangle = UnitRectangle()
        // 打印：1 1
        print(unitRectangle.width, unitRectangle.height)

        var narrowRectangle = NarrowRectangle()
        // 打印：3 2
        print(narrowRectangle.width, narrowRectangle.height)

        narrowRectangle.width = 100
        narrowRectangle.height = 100
        // 打印：4 5
        print(narrowRectangle.width, narrowRectangle.height)

        var mixedRectangle = MixedRectangle()
        // 打印：1
        print(mixedRectangle.height)

        mixedRectangle.height = 20
        // 打印：12
        print(mixedRectangle.height)


        // 从属性包装器中呈现一个值
        zeroRectangle.width = 4
        print(zeroRectangle.$width)

        zeroRectangle.width = 55
        print(zeroRectangle.$width)

        var sizedRectangle = SizedRectangle()
        print("sizedRectangle.width: \(sizedRectangle.width), sizedRectangle.height: \(sizedRectangle.height)")
        print("sizedRectangle.resizeOverMaximum: \(sizedRectangle.resizeOverMaximum(to: .small))", "sizedRectangle.width: \(sizedRectangle.width)", "sizedRectangle.height: \(sizedRectangle.height)")
        print("sizedRectangle.resizeOverMaximum: \(sizedRectangle.resizeOverMaximum(to: .large))", "sizedRectangle.width: \(sizedRectangle.width)", "sizedRectangle.height: \(sizedRectangle.height)")
    }

    @propertyWrapper
    struct TwelveOrLess {
        /*
         使用属性包装器时，你只需在定义属性包装器时编写一次管理代码，然后应用到多个属性上来进行复用。
         */
        private var number: Int

        var wrappedValue: Int {
            get {
                return number
            }
            set {
                number = min(newValue, 12)
            }
        }

        init(number: Int = 0) {
            self.number = number
        }
    }

//    struct SmallRectangle {
//        private var _width = TwelveOrLess()
//        private var _height = TwelveOrLess()
//
//        var width: Int {
//            get {
//                return _width.wrappedValue
//            }
//            set {
//                _width.wrappedValue = newValue
//            }
//        }
//
//        var height: Int {
//            get {
//                return _height.wrappedValue
//            }
//            set {
//                _height.wrappedValue = newValue
//            }
//        }
//    }

    struct SmallRectangle {
        @TwelveOrLess var width: Int
        @TwelveOrLess var height: Int
    }

    @propertyWrapper
    struct SmallNumber {
        private var maximum: Int
        private var number: Int
        var projectedValue: Bool

        var wrappedValue: Int {
            get {
                return number
            }
            set {
//                number = min(newValue, maximum)
                if newValue > maximum {
                    number = maximum
                    projectedValue = true
                } else {
                    number = newValue
                    projectedValue = false
                }
            }
        }

        init() {
            maximum = 12
            number = 0
            projectedValue = false
        }

        init(wrappedValue: Int) {
            maximum = 12
            self.number = min(wrappedValue, maximum)
            projectedValue = false
        }

        init(wrappedValue: Int, maximum: Int) {
            self.maximum = maximum
            self.number = min(wrappedValue, maximum)
            projectedValue = false
        }
    }

    struct ZeroRectangle {
        @SmallNumber var width: Int
        @SmallNumber var height: Int
    }

    struct UnitRectangle {
        @SmallNumber var height: Int = 1
        @SmallNumber var width: Int = 1
    }

    struct NarrowRectangle {
        @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
        @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    }

    struct MixedRectangle {
        @SmallNumber(maximum: 9) var width: Int = 2
        @SmallNumber var height: Int = 1
    }

    enum SizeType {
        case small, large
    }

    struct SizedRectangle {
        @SmallNumber(wrappedValue: 0, maximum: 12) var width: Int
        @SmallNumber(wrappedValue: 0, maximum: 12) var height: Int

        mutating func resizeOverMaximum(to sizeType: SizeType) -> Bool {
            /*
             当从类型的一部分代码中访问被呈现值，例如属性 getter 或实例方法，你可以在属性名称之前省略 self.，就像访问其他属性一样。以下示例中的代码用 $height 和 $width 引用包装器 height 和 width 的被呈现值
             */
            switch sizeType {
            case .small:
                width = 5
                height = 10
            case .large:
                width = 50
                height = 100
            }
            return $width || $height
        }
    }

    // MARK: - 全局变量和局部变量
    /*
     计算属性和观察属性所描述的功能也可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类型之外定义的变量。局部变量是在函数、方法或闭包内部定义的变量。
     全局的常量或变量都是延迟计算的，跟 延时加载存储属性 相似，不同的地方在于，全局的常量或变量不需要标记 lazy 修饰符。
     局部范围的常量和变量从不延迟计算。
     */

    // MARK: - 类型属性
    /*
     实例属性属于一个特定类型的实例，每创建一个实例，实例都拥有属于自己的一套属性值，实例之间的属性相互独立。
     你也可以为类型本身定义属性，无论创建了多少个该类型的实例，这些属性都只有唯一一份。这种属性就是类型属性。

     注意：跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。
     存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符。

     在 C 或 Objective-C 中，与某个类型关联的静态常量和静态变量，是作为 global（全局）静态变量定义的。但是在 Swift 中，类型属性是作为类型定义的一部分写在类型最外层的花括号内，因此它的作用范围也就在类型支持的范围内。
     使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写
     */
    private func typeProperties() {
        // 获取和设置类型属性的值
        // 打印：Some structure value. 1
        print(SomeStructure.storedTypeProperty, SomeStructure.computedTypeProperty)
        SomeStructure.storedTypeProperty = "Another structure value."

        // 打印：Another structure value. 1
        print(SomeStructure.storedTypeProperty, SomeStructure.computedTypeProperty)

        // 打印：Some enumeration value. 6
        print(SomeEnumeration.storedTypeProperty, SomeEnumeration.computedTypeProperty)

        // 打印：Some class value. 27 107
        print(SomeClass.storedTypeProperty, SomeClass.computedTypeProperty, SomeClass.overrideableComputedTypeProperty)

        // 打印：Some class value. 27 214
        print(ChildOfSomeClass.storedTypeProperty, ChildOfSomeClass.computedTypeProperty, ChildOfSomeClass.overrideableComputedTypeProperty)
        SomeClass.storedTypeProperty = "Another class value."
        ChildOfSomeClass.storedTypeProperty = "Another child class value."

        // 打印：Another child class value. 27 107
        // 父子类继承后，非重写的计算型类型属性 overrideableComputedTypeProperty 外，其他属性都是只有唯一一份非相互独立的
        print(SomeClass.storedTypeProperty, SomeClass.computedTypeProperty, SomeClass.overrideableComputedTypeProperty)

        // 打印：Another child class value. 27 214
        print(ChildOfSomeClass.storedTypeProperty, ChildOfSomeClass.computedTypeProperty, ChildOfSomeClass.overrideableComputedTypeProperty)

        let childOfSomeClass = ChildOfSomeClass()
        print(childOfSomeClass.otherProperty)
        childOfSomeClass.otherProperty = "Another child class value."

        // 左右两个声道的音量允许在 0 到 10 之间的整数
        var leftChannel = AudioChannel()
        var rightChannel = AudioChannel()
        leftChannel.currentLevel = 7
        print(leftChannel.currentLevel)
        print(AudioChannel.maxInputLevelForAllChannels)

        rightChannel.currentLevel = 11
        print(rightChannel.currentLevel)
        print(AudioChannel.maxInputLevelForAllChannels)
    }

    struct SomeStructure {
        static var storedTypeProperty = "Some structure value."
        static var computedTypeProperty: Int {
            return 1
        }
    }

    enum SomeEnumeration {
        static var storedTypeProperty = "Some enumeration value."
        static var computedTypeProperty: Int {
            return 6
        }
    }

    class SomeClass {
        static var storedTypeProperty = "Some class value."
        static var computedTypeProperty: Int {
            return 27
        }
        class var overrideableComputedTypeProperty: Int {
            return 107
        }

        init() {
            print("SomeClass object initial")
        }
    }

    class ChildOfSomeClass : SomeClass {
        var otherProperty: String

        override convenience init() {
            self.init(otherProperty: "Child class value.")
        }

        init(otherProperty: String) {
            self.otherProperty = otherProperty
            super.init()

            print("ChildOfSomeClass object initial")
        }

        override class var overrideableComputedTypeProperty: Int {
            return super.overrideableComputedTypeProperty * 2
        }
    }

    struct AudioChannel {
        /// 音量的最大上限阈值，它是一个值为 10 的常量，对所有实例都可见，如果音量高于 10，则取最大上限值 10
        static let thresholdLevel = 10
        /// 所有 AudioChannel 实例的最大输入音量，初始值是 0
        static var maxInputLevelForAllChannels = 0
        /// 当前声道现在的音量，取值为 0 到 10
        var currentLevel: Int = 0 {
            didSet {
                if currentLevel > AudioChannel.thresholdLevel {
                    // 将当前音量限制在阈值之内
                    currentLevel = AudioChannel.thresholdLevel
                }
                if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                    // 存储当前音量作为新的最大输入音量
                    AudioChannel.maxInputLevelForAllChannels = currentLevel
                }
            }
        }
    }
}