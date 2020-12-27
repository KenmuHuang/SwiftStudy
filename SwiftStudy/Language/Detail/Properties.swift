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



        // 简化 Setter 声明


        // 简化 Getter 声明


        // 只读计算属性



        // 设置被包装属性的初始值


        // 从属性包装器中呈现一个值



        // 类型属性语法


        // 获取和设置类型属性的值

    }

    // MARK: - 存储属性
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


    // MARK: - 属性观察器


    // MARK: - 属性包装器


    // MARK: - 全局变量和局部变量


    // MARK: - 类型属性

}