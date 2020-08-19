//
// Created by KenmuHuang on 2020/8/17.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import UIKit

class Generic {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        let repeatingItems = makeArray(repeating: "knock", numberOfTimes: 4)
        print(repeatingItems)

        var possibleInteger: OptionalValue<Int> = .none
        possibleInteger = .some(100)
        print(possibleInteger)

        let elements = anyCommonElements([1, 2, 3], [3])
        print("[1, 2, 3], [3] haveCommon = \(elements.haveCommon), commonElements = \(elements.commonElements)")
    }
}

///
/// 泛型函数或类型：生成重复元素的数组
/// - Parameters:
///   - item: 元素
///   - numberOfTimes: 重复次数
/// - Returns: 重复元素的数组
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

///
/// 可以创建泛型函数、类、枚举和结构体：泛型枚举
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}

///
/// 泛型使用 where 来指定对类型的一系列需求：限定类型实现某一个协议，限定两个类型是相同的，或者限定某个类必须有一个特定的父类
/// - Parameters:
///   - lhs:左边序列参数
///   - rhs:右边序列参数
/// - Returns: （两个序列是否存在交集元素，交集元素数组）
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> (haveCommon: Bool, commonElements: [T.Element])
    where T.Element: Equatable, T.Element == U.Element {
    var haveCommon = false
    var commonElements = [T.Element]()
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                haveCommon = true
                commonElements.append(lhsItem)
            }
        }
    }
    return (haveCommon, commonElements)
}