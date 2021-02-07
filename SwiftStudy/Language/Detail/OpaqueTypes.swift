//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

let sign = "\n"

///
/// 不透明类型：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/23_opaque_types
class OpaqueTypes: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        theProblemThatOpaqueTypesSolve()
        returningAnOpaqueType()
        differencesBetweenOpaqueTypesAndProtocolTypes()
    }
}

// MARK: - 不透明类型解决的问题
private func theProblemThatOpaqueTypesSolve() {
    /*
     暴露构造所用的具体类型会造成类型信息的泄露，因为 ASCII 几何图形模块的部分公开接口必须声明完整的返回类型，而实际上这些类型信息并不应该被公开声明。输出同一种几何图形，模块内部可能有多种实现方式，而外部使用时，应该与内部各种变换顺序的实现逻辑无关。诸如 JoinedShape 和 FlippedShape 这样包装后的类型，模块使用者并不关心，它们也不应该可见。模块的公开接口应该由拼接、翻转等基础操作组成，这些操作也应该返回独立的 Shape 类型的值。
     */
    let smallTriangle = Triangle(size: 3)
    print("\(smallTriangle.draw())\n")

    let flippedTriangle = FlippedShape(shape: smallTriangle)
    print("\(flippedTriangle.draw())\n")

    let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
    print("\(joinedTriangles.draw())\n")
}

protocol CustomShape {
    func draw() -> String
}

struct Triangle: CustomShape {
    var size: Int

    func draw() -> String {
        var result = [String]()
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: sign)
    }
}

struct FlippedShape<T: CustomShape>: CustomShape {
    var shape: T

    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: sign)
    }
}

struct JoinedShape<T: CustomShape, U: CustomShape>: CustomShape {
    var top: T
    var bottom: U

    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

// MARK: - 返回不透明类型
private func returningAnOpaqueType() {
    /*
     这个例子凸显了不透明返回类型和泛型的相反之处。makeTrapezoid() 中代码可以返回任意它需要的类型，只要这个类型是遵循 CustomShape 协议的，就像调用泛型函数时可以使用任何需要的类型一样。这个函数的调用代码需要采用通用的方式，就像泛型函数的实现代码一样，这样才能让 makeTrapezoid() 返回的任何 CustomShape 类型的值都能被正常使用。

     如果函数中有多个地方返回了不透明类型，那么所有可能的返回值都必须是同一类型。即使对于泛型函数，不透明返回类型可以使用泛型参数，但仍需保证返回类型唯一。
     */
    if #available(iOS 13.0.0, *) {
        let trapezoid = makeTrapezoid()
        print("\(trapezoid.draw())\n")

        let smallTriangle = Triangle(size: 3)
        let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
        print("\(opaqueJoinedTriangles.draw())\n")
    } else {
        // Fallback on earlier versions
    }
}

struct CustomSquare: CustomShape {
    var size: Int

    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: sign)
    }
}

@available(iOS 13.0.0, *)
func makeTrapezoid() -> some CustomShape {
    let top = Triangle(size: 2)
    let middle = CustomSquare(size: 4)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid
}

@available(iOS 13.0.0, *)
func flip<T: CustomShape>(_ shape: T) -> some CustomShape {
    return FlippedShape(shape: shape)
}

@available(iOS 13.0.0, *)
func join<T: CustomShape, U: CustomShape>(_ top: T, _ bottom: U) -> some CustomShape {
    return JoinedShape(top: top, bottom: bottom)
}

//@available(iOS 13.0.0, *)
//func invalidFlip<T: CustomShape>(_ shape: T) -> some CustomShape {
//    if shape is CustomSquare {
//        return shape // 错误：返回类型不一致
//    }
//    return FlippedShape(shape: shape) // 错误：返回类型不一致
//}

// MARK: - 不透明类型和协议类型的区别
private func differencesBetweenOpaqueTypesAndProtocolTypes() {
    /*
     虽然使用不透明类型作为函数返回值，看起来和返回协议类型非常相似，但这两者有一个主要区别，就在于是否需要保证类型一致性。一个不透明类型只能对应一个具体的类型，即便函数调用者并不能知道是哪一种类型；协议类型可以同时对应多个类型，只要它们都遵循同一协议。总的来说，协议类型更具灵活性，底层类型可以存储更多样的值，而不透明类型对这些底层类型有更强的限定。

     twelve 的类型可以被推断出为 Int， 这说明了类型推断适用于不透明类型。在 makeOpaqueContainer(item:) 的实现中，底层类型是不透明集合 [T]。在上述这种情况下，T 就是 Int 类型，所以返回值就是整数数组，而关联类型 Item 也被推断出为 Int。Container 协议中的 subscipt 方法会返回 Item，这也意味着 twelve 的类型也被能推断出为 Int。
     */
    if #available(iOS 13.0.0, *) {
        let opaqueContainer = makeOpaqueContainer(item: 12)
        let twelve = opaqueContainer[0]
        print(type(of: twelve))
    } else {
        // Fallback on earlier versions
    }
}

@available(iOS 13.0.0, *)
func makeOpaqueContainer<T>(item: T) -> some Container {
    return [item]
}

// 错误：有关联类型的协议不能作为返回类型。
//func makeProtocolContainer<T>(item: T) -> Container {
//    return [item]
//}

// 错误：没有足够多的信息来推断 C 的类型。
//func makeProtocolContainer<T, C: Container>(item: T) -> C {
//    return [item]
//}