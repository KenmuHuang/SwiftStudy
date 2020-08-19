//
// Created by KenmuHuang on 2020/8/16.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import UIKit

class ProtocolAndExtension {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        var simpleInt = 7
        print(simpleInt.adjust())

        let simpleClass = SimpleClass()
        simpleClass.anotherProperty = 6000
        print(simpleClass.adjust())

        var simpleStructure = SimpleStructure()
        print(simpleStructure.adjust())

        var simpleEnumeration = SimpleEnumeration.apple
        print(simpleEnumeration.adjust())
    }
}

/// 自定义协议
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust() -> String
}

/// 扩展：扩展重写的属性或方法为可选
extension ExampleProtocol {
    var simpleDescription: String {
        return "optional Property"
    }
}

/// 扩展 Int 类型
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }

    mutating func adjust() -> String {
        self += 42
        return simpleDescription
    }
}

/// 类（遵循自定义协议）
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty = 69105

    func adjust() -> String {
        simpleDescription += " Now 100% adjusted. anotherProperty = \(anotherProperty)"
        return simpleDescription
    }
}

/// 结构（遵循自定义协议）
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    var anotherProperty = 69105

    mutating func adjust() -> String {
        simpleDescription += " (adjusted), anotherProperty = \(anotherProperty)"
        return simpleDescription
    }
}

/// 枚举（遵循自定义协议）
enum SimpleEnumeration: Int, ExampleProtocol {
    case apple = 3
    case google, microsoft

    mutating func adjust() -> String {
        return simpleDescription + ". A simple enumeration (adjusted), self = \(self), rawValue = \(self.rawValue)"
    }
}
