//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 内存安全：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/25_memory_safety
class MemorySafety: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        understandingConflictingAccessToMemory()
        conflictingAccessToInOutParameters()
        conflictingAccessToSelfInMethods()
        conflictingAccessToProperties()
    }
}

// MARK: - 理解内存访问冲突
private func understandingConflictingAccessToMemory() {
    /*
     注意：如果你写过并发和多线程的代码，内存访问冲突也许是同样的问题。然而，这里访问冲突的讨论是在单线程的情境下讨论的，并没有使用并发或者多线程。如果你曾经在单线程代码里有访问冲突，Swift 可以保证你在编译或者运行时会得到错误。对于多线程的代码，可以使用 Thread Sanitizer 去帮助检测多线程的冲突。

     内存访问冲突时，要考虑内存访问上下文中的这三个性质：访问是读还是写，访问的时长，以及被访问的存储地址。特别是，冲突会发生在当你有两个访问符合下列的情况：
     1、至少有一个是写访问
     2、它们访问的是同一个存储地址
     3、它们的访问在时间线上部分重叠

     然而，有几种被称为长期访问的内存访问方式，会在别的代码执行时持续进行。瞬时访问和长期访问的区别在于别的代码有没有可能在访问期间同时访问，也就是在时间线上的重叠。一个长期访问可以被别的长期访问或瞬时访问重叠。
     重叠的访问主要出现在使用 in-out 参数的函数和方法或者结构体的 mutating 方法里。
     */
    // 向 one 所在的内存区域发起一次写操作
    var one = 1

    // 向 one 所在的内存区域发起一次读操作
    print("We're number \(one)!")

    // 内存访问性质
    var myNumber = 1
    myNumber = oneMore(than: myNumber)
    print(myNumber)
}

func oneMore(than number: Int) -> Int {
    return number + 1
}

// MARK: - In-Out 参数的访问冲突
private func conflictingAccessToInOutParameters() {
    // 同一个属性瞬间读写操作冲突；运行时报错：Simultaneous accesses to 0x1155e35b8, but modification requires exclusive access.
//    increment(&stepSize)

    // 显式拷贝
    var copyOfStepSize = stepSize
    increment(&copyOfStepSize)

    stepSize = copyOfStepSize
    print("stepSize is \(stepSize)")

    // 同一个属性作为多个输入输出参数，发起两个写访问同时访问同一个的存储地址冲突；编译时报错：Inout arguments are not allowed to alias each other
    var playerOneScore = 42
    var playerTwoScore = 30
//    balance(&playerOneScore, &playerOneScore)
    balance(&playerOneScore, &playerTwoScore)
    print("playerOneScore is \(playerOneScore), playerTwoScore is \(playerTwoScore)")
}

var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

// MARK: - 方法里 self 的访问冲突
private func conflictingAccessToSelfInMethods() {
    // 同一个属性作为多个输入输出参数，发起两个写访问同时访问同一个的存储地址冲突；编译时报错：Inout arguments are not allowed to alias each other
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    var maria = Player(name: "Maria", health: 5, energy: 10)
//    oscar.shareHealth(with: &oscar)
    oscar.shareHealth(with: &maria)
    print("\(oscar.name)'s health is \(oscar.health), \(maria.name)'s health is \(maria.health)")
}

struct Player {
    static let maxHealth = 10

    var name: String
    var health: Int
    var energy: Int

    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

// MARK: - 属性的访问冲突
private func conflictingAccessToProperties() {
    /*
     如结构体，元组和枚举的类型都是由多个独立的值组成的，例如结构体的属性或元组的元素。因为它们都是值类型，修改值的任何一部分都是对于整个值的修改，意味着其中一个属性的读或写访问都需要访问整一个值。例如：全局下的元组元素的写访问重叠会产生冲突，而在方法内局部下编译器就会可以保证这个重叠访问是安全的

     限制结构体属性的重叠访问对于保证内存安全不是必要的。保证内存安全是必要的，但因为访问独占权的要求比内存安全还要更严格——意味着即使有些代码违反了访问独占权的原则，也是内存安全的，所以如果编译器可以保证这种非专属的访问是安全的，那 Swift 就会允许这种行为的代码运行。特别是当你遵循下面的原则时，它可以保证结构体属性的重叠访问是安全的：
     1、你访问的是实例的存储属性，而不是计算属性或类的属性
     2、结构体是本地变量的值，而非全局变量
     3、结构体要么没有被闭包捕获，要么只被非逃逸闭包捕获了
     */
    // 元组或结构体多个元素在全局下会瞬间对整个值类型对象实例发起写访问重叠造成冲突；运行时报错：Simultaneous accesses to 0x10cb59aa0, but modification requires exclusive access.
//    balance(&playerInformationError.health, &playerInformationError.energy)
//    balance(&playerError.health, &playerError.energy)

    var playerInformation = (health: 10, energy: 20)
    balance(&playerInformation.health, &playerInformation.energy)
    print("playerInformation.health is \(playerInformation.health), playerInformation.energy is \(playerInformation.energy)")
}

var playerInformationError = (health: 10, energy: 20)
var playerError = Player(name: "Holly", health: 10, energy: 10)