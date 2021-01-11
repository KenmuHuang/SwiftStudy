//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 错误处理：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/17_error_handling
class ErrorHandling: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        do {
            try representingAndThrowingErrors()
        } catch {
            print(error)
        }
        handlingErrors()
        specifyingCleanupActions()
    }

    // MARK: - 表示与抛出错误
    private func representingAndThrowingErrors() throws {
        let ownCoins = 3
        let coinsNeeded = 5
        if ownCoins < coinsNeeded {
            throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
        }
    }

    ///
    /// 自动贩卖机
    enum VendingMachineError: Error {
        /// 选择无效
        case invalidSelection
        /// 金额不足
        case insufficientFunds(coinsNeeded: Int)
        /// 缺货
        case outOfStock
    }

    // MARK: - 处理错误
    private func handlingErrors() {
        // 用 throwing 函数传递错误

        // 用 Do-Catch 处理错误

        // 将错误转换成可选值

        // 禁用错误传递

    }

    // MARK: - 指定清理操作
    private func specifyingCleanupActions() {

    }
}