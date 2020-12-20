//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 闭包：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/07_closures
class Closures: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let descendingNames = sort(names: names, isDescending: true);
        let ascendingNames = sort(names: names, isDescending: false)
        print("name = \(names), descendingNames = \(descendingNames), ascendingNames = \(ascendingNames)")
    }

    // MARK: - 闭包表达式
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }

    func forward(_ s1: String, _ s2: String) -> Bool {
        return s1 < s2
    }
    
    func sort(names: [String], isDescending: Bool) -> [String] {
        if isDescending {
            return names.sorted(by: {(s1: String, s2: String) -> Bool in
                return s1 > s2
            })
        } else {
            return names.sorted(by: {(s1: String, s2: String) -> Bool in
                return s1 < s2
            })
        }

//        return names.sorted(by: (isDescending ? backward : forward))
    }
}