//
//  Select.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2021/5/18.
//  Copyright © 2021 KenmuHuang. All rights reserved.
//

import Foundation

/// 选择排序；时间复杂度为 O(n的2次方)
class Select: MainProtocol, AlgorithmProtocol {
    func main() {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        var testArray = defaultArray
        print("testArray = \(testArray) => \(sort(array: &testArray))")
    }

    func sort(array: inout [Int]) -> [Int] {
        for i in 0..<array.count {
            var minIndex = i
            for j in i + 1..<array.count {
                if array[minIndex] > array[j] {
                    // i 为外循环数组下标，j 为内循环数组下标；如果 i 对应元素值大于 i + 1 或之后的元素值，就更新最小值下标为 j
                    minIndex = j
                }
            }
            if minIndex != i {
                // 内循环数组后，记录到最小值下标已更新，才进行值交换；避免无用功
                let temp = array[i]
                array[i] = array[minIndex]
                array[minIndex] = temp
            }
            print("\(i + 1): \(array)")
        }
        return array
    }
}