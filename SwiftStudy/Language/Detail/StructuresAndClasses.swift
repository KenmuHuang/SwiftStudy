//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 结构体和类：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/09_structures_and_classes
class StructuresAndClasses: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        // 结构体和类的实例
        let someResolution = Resolution()
        let someVideoMode = VideoMode()


        // 属性访问
        print("The width of someResolution is \(someResolution.width)")
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")
        someVideoMode.resolution.width = 1280
        print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
        print(someVideoMode.debugDescription)


        // 结构体类型的成员逐一构造器
        var vga = Resolution(height: 480)
        print("The width of vga is \(vga.width), the height of vga is \(vga.height)")
        vga.width = 320
        vga.height = 240
        print("The width of vga is now \(vga.width), the height of vga is now \(vga.height)")


        // 结构体和枚举是值类型
        // 值类型是这样一种类型，当它被赋值给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
        // Swift 中所有的基本类型：整数（integer）、浮点数（floating-point number）、布尔值（boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，其底层也是使用结构体实现的。
        let hd = Resolution(width: 1920, height: 1080)
        print("The width of hd is \(hd.width), the height of hd is \(hd.height)")
        var cinema = hd
        cinema.width = 2048
        print("Cinema is now  \(cinema.width) pixels wide")
        print("The width of hd is now \(hd.width), the height of hd is now \(hd.height)")

        var currentDirection = CompassPoint.west
        let rememberedDirection = currentDirection
        currentDirection.turnNorth()
        print("The current direction is \(currentDirection)")
        print("The remembered direction is \(rememberedDirection)")


        // 类是引用类型
        // 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，使用的是已存在实例的引用，而不是其拷贝。
        let tenEighty = VideoMode(resolution: hd, interlaced: true, frameRate: 25.0, name: "1080i")
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
        print("tenEighty.debugDescription: " + tenEighty.debugDescription)
        print("alsoTenEighty.description : \(alsoTenEighty.description)")
        print("The tenEighty is equal to the alsoTenEighty? \(tenEighty == alsoTenEighty)")


        // 恒等运算符
        // “相同”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同。“相同”表示两个类类型（class type）的常量或者变量引用同一个类实例。“等于”表示两个实例的值“相等”或“等价”，判定时要遵照设计者定义的评判标准。
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
        }
    }
}

// MARK: - 类型定义的语法
///
/// 像素的分辨率结构体
struct Resolution {
    var width = 0
    var height = 0
}

///
/// 指南针枚举
enum CompassPoint {
    case east, south, west, north
    mutating func turnNorth() {
        self = .north
    }
}

///
/// 显示器视频模式类
class VideoMode: CustomStringConvertible, CustomDebugStringConvertible, Hashable {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?

    init() {

    }

    init(resolution: Resolution, interlaced: Bool, frameRate: Double, name: String?) {
        self.resolution = resolution
        self.interlaced = interlaced
        self.frameRate = frameRate
        self.name = name
    }

    ///
    /// description：程序中 log 会调用的方法
    var description: String {
        "VideoMode3(resolution: \(resolution), " +
            "interlaced: \(interlaced), " +
            "frameRate: \(frameRate), " +
            "name: \(name ?? ""))"
    }

    ///
    /// debugDescription 则是断点调试时，在控制台使用 po 命令打印会调用的方法
    var debugDescription: String {
        """
        VideoMode(resolution: \(resolution), \
        interlaced: \(interlaced), \
        frameRate: \(frameRate), \
        name: \(String(describing: name)))
        """
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(interlaced)
        hasher.combine(frameRate)
        hasher.combine(name)
    }

    static func ==(lhs: VideoMode, rhs: VideoMode) -> Bool {
        if lhs === rhs {
            return true
        }
        if type(of: lhs) != type(of: rhs) {
            return false
        }
        return lhs.interlaced == rhs.interlaced
            && lhs.frameRate == rhs.frameRate
            && lhs.name == rhs.name
    }
}