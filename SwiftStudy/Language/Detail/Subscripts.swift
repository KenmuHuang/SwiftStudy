//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 下标：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/12_subscripts
class Subscripts: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        subscriptSyntax()
        subscriptUsage()
        subscriptOptions()
        typeSubscripts()
    }
}

// MARK: - 下标语法
private func subscriptSyntax() {
    let threeTimesTable = TimesTable(multiplier: 3)
    print("Six times three is \(threeTimesTable[6])")
}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

// MARK: - 下标用法
private func subscriptUsage() {
    // capacity 的分配以上次分配 * 2 是否能容纳扩充，忽略值为 nil 的元素。count 也一样会忽略值为 nil 的元素。
    var numberOfLegs = [
        "spider": 8,
        "ant": 6,
        "cat": 4
    ]
    numberOfLegs["bird"] = 2

    // 注意：Swift 的 Dictionary 类型的下标接受并返回可选类型的值。上例中的 numberOfLegs 字典通过下标返回的是一个 Int? 或者说“可选的 int”。Dictionary 类型之所以如此实现下标，是因为不是每个键都有对应的值，同时这也提供了一种通过键删除对应值的方式，只需将键对应的值赋值为 nil 即可。
    numberOfLegs["monster"] = nil

    // 打印：The count of numberOfLegs is 4
    print("The count of numberOfLegs is \(numberOfLegs.count)")

    for item in numberOfLegs {
        print("Key is \(item.key), value is \(item.value)")
    }
}

// MARK: - 下标选项
/*
 与函数一样，下标可以接受不同数量的参数，并且为这些参数提供默认值，如在可变参数 和 默认参数值 中所述。但是，与函数不同的是，下标不能使用 in-out 参数。

 一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标。它通常被称为下标的重载。
 */
private func subscriptOptions() {
    var matrix = Matrix(rows: 2, columns: 2)
    matrix[0, 1] = 1.5
    matrix[1, 0] = 3.2

    for row in 0..<matrix.rows {
        for column in 0..<matrix.columns {
            if matrix.indexIsValid(row: row, column: column) {
                print("matrix[\(row), \(column)] = \(matrix[row, column])")
            } else {
                print("row = \(row) and column = \(column) out of range")
            }
        }
    }

    // 断言将会触发，因为 [2, 2] 已经超过了 matrix 的范围
//    let someValue = matrix[2, 2]
}

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: 0.0, count: rows * columns)
    }

    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[row * columns + column]
        }
        set(newValue) {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[row * columns + column] = newValue
        }
    }
}

// MARK: - 类型下标
private func typeSubscripts() {
    print("Choose \(Planet[4])")
}

/// 行星枚举
/// mercury - 水星，venus - 金星，earth - 地球，mars - 火星，jupiter - 木星，saturn - 土星，uranus - 天王星，neptune - 海王星
enum Planet: Int {
    case unknown = 0, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n) ?? .unknown
    }
}