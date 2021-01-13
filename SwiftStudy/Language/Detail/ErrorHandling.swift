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
    /// 自动贩卖机错误枚举
    enum VendingMachineError: Error {
        /// 选择无效
        case invalidSelection
        /// 缺货
        case outOfStock
        /// 金额不足
        case insufficientFunds(coinsNeeded: Int)
    }

    // MARK: - 处理错误
    private func handlingErrors() {
        // 用 throwing 函数传递错误
        /*
         注意：只有 throwing 函数可以传递错误。任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。
         */
        var vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        try? buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)


        // 用 Do-Catch 处理错误



        // 将错误转换成可选值


        // 禁用错误传递

    }

    ///
    /// 商品
    struct Item {
        var price: Int
        var count: Int
    }

    ///
    /// 自动贩卖机类
    class VendingMachine {
        var inventory = [
            "Candy Bar": Item(price: 12, count: 7),
            "Chips": Item(price: 10, count: 4),
            "Pretzels": Item(price: 7, count: 11)
        ]
        var coinsDeposited = 0

        func vend(itemNamed name: String) throws {
            // 商品是否存在
            guard let item = inventory[name] else {
                throw VendingMachineError.invalidSelection
            }

            // 商品是否有库存
            guard item.count > 0 else {
                throw VendingMachineError.outOfStock
            }

            // 金币是否够购买商品
            guard item.price <= coinsDeposited else {
                throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
            }

            coinsDeposited -= item.price

            var newItem = item
            newItem.count -= 1
            inventory[name] = newItem

            // 分配商品
            print("Dispensing \(name)")
        }
    }

    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels",
    ]

    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }

    struct PurchasedSnack {
        let name: String

        init(name: String, vendingMachine: VendingMachine) throws {
            try vendingMachine.vend(itemNamed: name)
            self.name = name
        }
    }

    // MARK: - 指定清理操作
    private func specifyingCleanupActions() {

    }
}