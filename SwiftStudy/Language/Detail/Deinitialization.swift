//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 析构过程：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/15_deinitialization
class Deinitialization: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        howDeinitializationWorks()
        deinitializersInAction()
    }

    // MARK: - 析构过程原理
    private func howDeinitializationWorks() {
        /*
         Swift 会自动释放不再需要的实例以释放资源。如 自动引用计数 章节中所讲述，Swift 通过自动引用计数（ARC) 处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理。但是，当使用自己的资源时，你可能需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前手动去关闭该文件。

         在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数和圆括号。

         析构器是在实例释放发生前被自动调用的。你不能主动调用析构器。子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
         因为直到实例的析构器被调用后，实例才会被释放，所以析构器可以访问实例的所有属性，并且可以根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）。
         */
    }

    // MARK: - 析构器实践
    private func deinitializersInAction() {
        var playerOne: Player? = Player(coins: 100)
        print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
        print("There are now \(Bank.coinsInBank) coins left in the bank")

        var numberOfCoinsToWin = playerOne!.win(coins: 2_000)
        print("PlayerOne won \(numberOfCoinsToWin) coins & now has \(playerOne!.coinsInPurse) coins")
        print("The bank now only has \(Bank.coinsInBank) coins left")

        numberOfCoinsToWin = playerOne!.win(coins: 9000)
        print("PlayerOne won \(numberOfCoinsToWin) coins & now has \(playerOne!.coinsInPurse) coins")
        print("The bank now only has \(Bank.coinsInBank) coins left")

        // 实例会被释放，以便回收内存。在这之前，该实例的析构器被自动调用，玩家的硬币被返还给银行
        playerOne = nil
        print("PlayerOne has left the game")
        print("The bank now has \(Bank.coinsInBank) coins")
    }

    ///
    /// 游戏银行类
    class Bank {
        /// 管理一种虚拟硬币，确保流通的硬币数量永远不可能超过 10,000
        static var coinsInBank = 10_000

        ///
        /// 分发硬币
        /// - Parameter numberOfCoinsRequested: 请求的硬币数
        /// - Returns: 本次实际分发的硬币数
        static func distribute(coins numberOfCoinsRequested: Int) -> Int {
            let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
            coinsInBank -= numberOfCoinsToVend
            return numberOfCoinsToVend
        }

        ///
        /// 收集硬币
        /// - Parameter coins: 收集的硬币数
        static func receive(coins: Int) {
            coinsInBank += coins
        }
    }

    ///
    /// 游戏玩家类
    class Player {
        /// 零钱包
        var coinsInPurse: Int

        init(coins: Int) {
            coinsInPurse = Bank.distribute(coins: coins)
        }

        deinit {
            // 析构器的作用：将玩家的所有硬币都返还给银行
            Bank.receive(coins: coinsInPurse)
        }

        ///
        /// 赢得硬币
        /// - Parameter numberOfCoinsRequested: 请求的硬币数
        /// - Returns: 本次实际赢得的硬币数
        func win(coins numberOfCoinsRequested: Int) -> Int {
            let numberOfCoinsToWin = Bank.distribute(coins: numberOfCoinsRequested)
            coinsInPurse += numberOfCoinsToWin
            return numberOfCoinsToWin
        }
    }


}