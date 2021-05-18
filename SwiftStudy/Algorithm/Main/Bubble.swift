//
//  Bubble.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2021/5/18.
//  Copyright © 2021 KenmuHuang. All rights reserved.
//

import Foundation

/// 冒泡排序；时间复杂度为 O(n的2次方)
class Bubble: MainProtocol, AlgorithmProtocol {
    func main() {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        var testArray = defaultArray
        print("testArray = \(testArray) => \(sort(array: &testArray))")
    }

    func sort(array: inout [Int]) -> [Int] {
        for i in 0..<array.count {
            for j in i + 1..<array.count {
                if array[i] > array[j] {
                    // i 为外循环数组下标，j 为内循环数组下标；如果 i 对应元素值大于 i + 1 或之后的元素值，就进行值交换
                    let temp = array[i]
                    array[i] = array[j]
                    array[j] = temp
                }
            }
            print("\(i + 1): \(array)")
        }
        return array
    }
}