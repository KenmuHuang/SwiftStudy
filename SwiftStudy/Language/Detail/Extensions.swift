//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 扩展：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/20_extensions
class Extensions: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        extensionSyntax()
        computedProperties()
        initializers()
        methods()
        subscripts()
        nestedTypes()
    }

    // MARK: - 扩展的语法
    private func extensionSyntax() {
        /*
         扩展可以给一个现有的类，结构体，枚举，还有协议添加新的功能。它还拥有不需要访问被扩展类型源代码就能完成扩展的能力（即逆向建模）。扩展和 Objective-C 的分类很相似。（与 Objective-C 分类不同的是，Swift 扩展是没有名字的。）
         Swift 中的扩展可以：
         1、添加计算型实例属性和计算型类属性
         2、定义实例方法和类方法
         3、提供新的构造器
         4、定义下标
         5、定义和使用新的嵌套类型
         6、使已经存在的类型遵循（conform）一个协议

         注意：扩展可以给一个类型添加新的功能，但是不能重写已经存在的功能。
         */
    }

    // MARK: - 计算型属性
    private func computedProperties() {

    }

    // MARK: - 构造器
    private func initializers() {

    }

    // MARK: - 方法
    private func methods() {
        // 可变实例方法
    }

    // MARK: - 下标
    private func subscripts() {

    }

    // MARK: - 嵌套类型
    private func nestedTypes() {

    }
}