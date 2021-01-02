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
        settingInitialValuesForStoredProperties()
    }

    // MARK: - 存储属性的初始赋值
    private func settingInitialValuesForStoredProperties() {
        // 构造器


        // 默认属性值

    }

    // MARK: - 自定义构造过程
    private func customizingInitialization() {
        // 形参的构造过程


        // 形参命名和实参标签


        // 不带实参标签的构造器形参


        // 可选属性类型


        // 构造过程中常量属性的赋值

    }

    // MARK: - 默认构造器
    private func defaultInitializers() {
        // 结构体的逐一成员构造器

    }

    // MARK: - 值类型的构造器代理
    private func initializerDelegationForValueTypes() {

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