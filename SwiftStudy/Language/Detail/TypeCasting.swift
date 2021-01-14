//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 类型转换：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/18_type_casting
class TypeCasting: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        classHierarchyForTypeCasting()
        checkingType()
        downCasting()
        typeCastingForAnyAndAnyObject()
    }

    // MARK: - 为类型转换定义类层次
    private func classHierarchyForTypeCasting() {
        
    }

    // MARK: - 检查类型
    private func checkingType() {
        
    }

    // MARK: - 向下转型
    private func downCasting() {
        
    }

    // MARK: - Any 和 AnyObject 的类型转换
    private func typeCastingForAnyAndAnyObject() {

    }
}