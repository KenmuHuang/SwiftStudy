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

        // 类型属性语法


        // 获取和设置类型属性的值

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


        // 从属性包装器中呈现一个值

    }

    @propertyWrapper
    struct TwelveOrLess {
        /*
         使用属性包装器时，你只需在定义属性包装器时编写一次管理代码，然后应用到多个属性上来进行复用。
         */
        private var number: Int

        init(number: Int = 0) {
            self.number = number
        }

        var wrappedValue: Int {
            get {
                return number
            }
            set {
                number = min(newValue, 12)
            }
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

    // MARK: - 全局变量和局部变量


    // MARK: - 类型属性

}