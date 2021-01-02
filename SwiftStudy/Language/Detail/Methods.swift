//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 方法：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/11_methods
class Methods: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        instanceMethods()
        typeMethods()
    }

    // MARK: - 实例方法
    /*
     结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法。
     */
    func instanceMethods() {
        let counter = Counter()
        counter.increment()

        // 打印：counter.count = 1
        print("counter.count = \(counter.count)")
        counter.increment(by: 5)

        // 打印：counter.count = 6
        print("counter.count = \(counter.count)")
        counter.reset()


        // self 属性
        var somePoint = Point(x: 1.0, y: 5.0)
        somePoint.x = 5.0
        if somePoint.isToTheRightOf(x: 1.0) {
            print("This point is to the right of the line where x == 1.0")
        }


        // 在实例方法中修改值类型
        somePoint.moveBy(x: 2.0, y: 3.0)

        // 打印：The point is now at (7.0, 8.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")


        // 在可变方法中给 self 赋值
        var ovenLight = TriStateSwitch.low
        ovenLight.next()

        // 打印：high
        print(ovenLight)
        ovenLight.next()

        // 打印：off
        print(ovenLight)
    }

    class Counter {
        /// 保持对当前计数器值的追踪
        var count = 0

        ///
        /// 让计数器按一递增
        func increment() {
            count += 1
        }

        ///
        /// 让计数器按一个指定的整数值递增
        /// - Parameter amount: 指定的整数值
        func increment(by amount: Int) {
            count += amount
        }

        ///
        /// 将计数器重置为0
        func reset() {
            count = 0
        }
    }

    struct Point {
        var x = 0.0, y = 0.0

        func isToTheRightOf(x: Double) -> Bool {
            // 实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用 self 属性来区分参数名称和属性名称。
            // 如果不使用 self 前缀，Swift会认为 x 的两个用法都引用了名为 x 的方法参数。
            return self.x > x
        }

        /*
         结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。

         但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择 可变（mutating）行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
         */
        mutating func moveBy(x deltaX: Double, y deltaY: Double) {
//            x += deltaX
//            y += deltaY

            // 可变方法能够赋给隐含属性 self 一个全新的实例
            self = Point(x: x + deltaX, y: y + deltaY)
        }
    }

    ///
    /// 三态切换枚举
    enum TriStateSwitch {
        case off, low, high

        mutating func next() {
            switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
                self = .off
            }
        }
    }

    // MARK: - 类型方法
    /*
     在方法的 func 关键字之前加上关键字 static，来指定类型方法。类还可以用关键字 class 来指定，从而允许子类重写父类该方法的实现。

     在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。

     因为允许在调用 advance(to:) 时候忽略返回值，不会产生编译警告，所以函数被标注为 @discardableResult 属性
     */
    func typeMethods() {
        var player = Player(name: "Alex")
        player.complete(level: 1)

        // 打印：
        print("Highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

        player = Player(name: "John")
        if player.tracker.advance(to: 6) {
            print("Player is now on level 6")
        } else {
            print("Level 6 has not yet been unlocked")
        }
    }

    ///
    /// 监测玩家的游戏发展情况的结构体（这是一个单人游戏，但也可以存储多个玩家在同一设备上的游戏信息）
    struct LevelTracker {
        static var highestUnlockedLevel = 1
        var currentLevel = 1

        ///
        /// 一旦新等级被解锁，它会更新 highestUnlockedLevel 的值
        /// - Parameter level: 被解锁的新等级
        static func unlock(_ level: Int) {
            if level > highestUnlockedLevel {
                highestUnlockedLevel = level
            }
        }

        ///
        /// 如果某个给定的等级已经被解锁，它将返回 true
        /// - Parameter level: 某个给定的等级
        /// - Returns: 某个给定的等级是否已经被解锁
        static func isUnlocked(_ level: Int) -> Bool {
            return level <= highestUnlockedLevel
        }

        @discardableResult
        ///
        /// 会在更新 currentLevel 之前检查所请求的新等级是否已经解锁，返回布尔值以指示是否已设置 currentLevel
        /// - Parameter level: 某个给定的等级
        /// - Returns: 是否已设置 currentLevel
        mutating func advance(to level: Int) -> Bool {
            if LevelTracker.isUnlocked(level) {
                currentLevel = level
                return true
            } else {
                return false
            }
        }
    }

    class Player {
        var tracker = LevelTracker()
        let name: String

        init(name: String) {
            self.name = name
        }

        func complete(level: Int) {
            LevelTracker.unlock(level + 1)
            tracker.advance(to: level + 1)
        }
    }
}
