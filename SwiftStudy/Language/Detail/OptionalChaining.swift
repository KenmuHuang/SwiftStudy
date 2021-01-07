//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 可选链：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/16_optional_chaining
class OptionalChaining: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        asAnAlternativeToForcedUnwrapping()
        definingModelClasses()
        accessingProperties()
        callingMethods()
        accessingSubscripts()
        linkingMultipleLevels()
        onMethodsWithOptionalReturnValues()
    }

    // MARK: - 使用可选链式调用代替强制解包
    private func asAnAlternativeToForcedUnwrapping() {
        let john = Person()

        // 如果使用叹号（!）强制解包获得这个 john 的 residence 属性中的 numberOfRooms 值，会触发运行时错误，因为这时 residence 没有可以解包的值
//        let roomCount = john.residence!.numberOfRooms

        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }

        var roomCount = john.residence?.numberOfRooms
        print("roomCount = \(roomCount ?? 0)")

        john.residence = Residence()
        roomCount = john.residence?.numberOfRooms
        print("roomCount = \(roomCount ?? 0)")

        john.residence?.numberOfRooms = 3
        roomCount = john.residence?.numberOfRooms
        print("roomCount = \(roomCount ?? 0)")
    }

    ///
    /// 住宅类
    class Residence {
        var numberOfRooms = 1
    }

    ///
    /// 人类
    class Person {
        var residence: Residence?
    }

    // MARK: - 为可选链式调用定义模型类
    private func definingModelClasses() {

    }

    // MARK: - 通过可选链式调用访问属性
    private func accessingProperties() {

    }

    // MARK: - 通过可选链式调用来调用方法
    private func callingMethods() {

    }

    // MARK: - 通过可选链式调用访问下标
    private func accessingSubscripts() {
        // 访问可选类型的下标

    }

    // MARK: - 连接多层可选链式调用
    private func linkingMultipleLevels() {

    }

    // MARK: - 在方法的可选返回值上进行可选链式调用
    private func onMethodsWithOptionalReturnValues() {

    }
}