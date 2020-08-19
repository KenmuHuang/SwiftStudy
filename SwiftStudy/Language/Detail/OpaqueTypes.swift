//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 不透明类型：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/23_opaque_types
class OpaqueTypes: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

    }
}