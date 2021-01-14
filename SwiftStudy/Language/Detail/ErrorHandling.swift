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
        // 第一种：逐个枚举元素遍历
        do {
            try buyFavoriteSnack(person: "Bob", vendingMachine: vendingMachine)
            print("Success! Yum.")
        } catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch {
            print("Unexpected error: \(error).")
        }

        vendingMachine.coinsDeposited = 6
        // 第二种：判断枚举类型
        do {
            try buyFavoriteSnack(person: "Eve", vendingMachine: vendingMachine)
        } catch is VendingMachineError {
            print("Couldn't buy that from the vending machine.")
        } catch {
            // error 为默认异常常量
            print("Unexpected non-vending-machine-related error: \(error)")
        }

        // 第三种：多个枚举元素一起遍历
        do {
            try buyFavoriteSnack(person: "John", vendingMachine: vendingMachine)
        } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
            print("Invalid selection, out of stock, or not enough money.")
        } catch {
            print("Unexpected non-vending-machine-related error: \(error)")
        }


        // 将错误转换成可选值
        let x = try? someThrowingFunction(isThrow: true)

        let y: Int?
        do {
            y = try someThrowingFunction(isThrow: true)
        } catch {
            y = nil
        }

        if x == nil && y == nil {
            print("x is nil, and y is also nil")
        }

        if let result = fetchData(url: "http://www.baidu.com") {
            print("code: \(result.code), data: \(result.data), message: \(result.message), url: \(result.url)")
        }

        // 禁用错误传递
        /*
         有时你知道某个 throwing 函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写 try! 来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误
         */
        let z = try! someThrowingFunction(isThrow: false)
        print("z is \(z)")
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

    func someThrowingFunction(isThrow: Bool) throws -> Int {
        if isThrow {
            throw VendingMachineError.outOfStock
        } else {
            return 10
        }
    }

    struct Data {
        var code: Int
        var data: [String : Any]
        var message: String
        var url: String
    }

    func fetchDataFromDisk(url: String) throws -> Data {
        if url.count > 0 {
            return Data.init(code: 0, data: ["data":"10"], message: "success", url: url)
        } else {
            throw VendingMachineError.outOfStock
        }
    }

    func fetchDataFromServer(url: String) throws -> Data {
        if url.count > 0 {
            return Data.init(code: 0, data: ["data":"10"], message: "success", url: url)
        } else {
            throw VendingMachineError.outOfStock
        }
    }

    func fetchData(url: String) -> Data? {
        if let data = try? fetchDataFromDisk(url: url) {
            return data
        }

        if let data = try? fetchDataFromServer(url: url) {
            return data
        }

        return nil
    }

    // MARK: - 指定清理操作
    private func specifyingCleanupActions() {
        /*
         defer 语句将代码的执行延迟到当前的作用域退出之前。该语句由 defer 关键字和要被延迟执行的语句组成。延迟执行的语句不能包含任何控制转移语句，例如 break、return 语句，或是抛出一个错误。延迟执行的操作会按照它们声明的顺序从后往前执行——也就是说，第一条 defer 语句中的代码最后才执行，第二条 defer 语句中的代码倒数第二个执行，以此类推。最后一条语句会第一个执行
         */
        do {
            try processFile(filename: "./Resources/John Appleseed.jpg")
        } catch {
            print(error)
        }
    }

    func processFile(filename: String) throws {
        if exists(filename) {
            let file = open(filename)
            defer {
                close(file)
                print("Finally second execute")
            }
            defer {
                print("Finally first execute")
            }
            while let line = try file.readline() {
                // 处理文件
                print("readline: \(line.content)")
            }
            // close(file) 会在这里被调用，即作用域的最后。
        }
    }

    func exists(_ filename: String) -> Bool {
        return true
    }

    func open(_ filename: String) -> File {
        return File()
    }

    func close(_ file: File) {
        // 关闭
    }

    class File {
        static var remainingLineCount  = 5
        func readline() throws -> FileStream? {
            if File.remainingLineCount > 0 {
                File.remainingLineCount -= 1
            }

            if File.remainingLineCount == 0 {
                throw VendingMachineError.outOfStock
            }

            return FileStream(content: "哈哈")
        }
    }

    class FileStream {
        var content: String

        init(content: String) {
            self.content = content
        }
    }

}