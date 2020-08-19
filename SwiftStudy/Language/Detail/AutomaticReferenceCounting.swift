//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 自动引用计数：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/24_automatic_reference_counting
class AutomaticReferenceCounting: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

    }
}