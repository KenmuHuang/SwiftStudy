//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 访问控制：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/26_access_control
class AccessControl: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

    }
}