//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 继承：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/13_inheritance
class Inheritance: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        definingABaseClass()
        subclassing()
        overriding()
        preventingOverrides()
    }

    // MARK: - 定义一个基类
    private func definingABaseClass() {
        let vehicle = Vehicle()
        print("Vehicle: \(vehicle.description)")
    }

    class Vehicle {
        var currentSpeed = 0.0
        var description: String {
            return "traveling at \(currentSpeed) miles per hour"
        }

        func makeNoise() {
            // 什么也不做——因为车辆不一定会有噪音
        }
    }

    // MARK: - 子类生成
    private func subclassing() {
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print("Bicycle: \(bicycle.description)")

        let tandem = Tandem()
        tandem.hasBasket = true
        tandem.currentSpeed = 22.0
        tandem.currentNumberOfPassengers = 2
        print("Tandem: \(tandem.description)")
    }

    class Bicycle: Vehicle {
        var hasBasket = false
    }

    class Tandem: Bicycle {
        var currentNumberOfPassengers = 0
    }

    // MARK: - 重写
    private func overriding() {
        // 访问超类的方法，属性及下标
        /*
         在合适的地方，你可以通过使用 super 前缀来访问超类版本的方法，属性或下标：
         1、在方法 someMethod() 的重写实现中，可以通过 super.someMethod() 来调用超类版本的 someMethod() 方法。
         2、在属性 someProperty 的 getter 或 setter 的重写实现中，可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
         3、在下标的重写实现中，可以通过 super[someIndex] 来访问超类版本中的相同下标。
         */


        // 重写方法
        let train = Train()
        train.makeNoise()


        // 重写属性
        let car = Car()
        car.currentSpeed = 25.0
        car.gear = 3
        print("Car: \(car.description)")

        let automaticCar = AutomaticCar()
        automaticCar.currentSpeed = 35.0
        print("AutomaticCar: \(automaticCar.description)")
    }

    class Train: Vehicle {
        override func makeNoise() {
            print("Choo Choo")
        }
    }

    class Car: Vehicle {
        var gear = 1

        /*
         你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。

         注意：如果你在重写属性中提供了 setter，那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过 super.someProperty 来返回继承来的值，其中 someProperty 是你要重写的属性的名字。
         */
        override var description: String {
            return super.description + " in gear \(gear)"
        }
    }

    class AutomaticCar: Car {
        /*
         注意：你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供 willSet 或 didSet 实现也是不恰当。 此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
         */
        override var currentSpeed: Double {
            didSet {
                gear = Int(currentSpeed / 10.0) + 1
            }
        }
    }

    // MARK: - 防止重写
    private func preventingOverrides() {
        var bus = Bus()
        bus.currentSpeed = 30.0
        print("Bus: \(bus.description)")
    }

    final class Bus: Vehicle {
        /*
         你可以通过把方法，属性或下标标记为 final 来防止它们被重写，只需要在声明关键字前加上 final 修饰符即可（例如：final var、final func、final class func 以及 final subscript）。
         任何试图对带有 final 标记的方法、属性或下标进行重写的代码，都会在编译时会报错。在类扩展中的方法，属性或下标也可以在扩展的定义里标记为 final。
         可以通过在关键字 class 前添加 final 修饰符（final class）来将整个类标记为 final 。这样的类是不可被继承的，试图继承这样的类会导致编译报错。
         */
        final var color = "Green"

        override var description: String {
            return super.description + ", the color is \(color)"
        }
    }
}