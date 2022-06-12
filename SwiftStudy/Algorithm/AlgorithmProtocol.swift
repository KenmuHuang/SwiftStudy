//
// Created by KenmuHuang on 2021/5/18.
// Copyright (c) 2021 KenmuHuang. All rights reserved.
//

import Foundation

protocol AlgorithmProtocol {
    var defaultArray: [Int] { get }
    mutating func sort(array: inout [Int]) -> [Int]
}

extension AlgorithmProtocol {
    var defaultArray: [Int] {
        [2, 1, 5, 9, 4, 0, 6, 3, 8, 7]
    }
}
