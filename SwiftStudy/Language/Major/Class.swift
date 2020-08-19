//
// Created by KenmuHuang on 2020/6/7.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import UIKit

class Class: NSObject {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        var shape = Shape()
        shape.numberOfSides = 7
        print(shape.simpleDescription())
        print(shape.simpleDescription(numberOfSides: 8))

        shape = Shape(numberOfSides: 9)
        print(shape.simpleDescription())

        let square = Square(10, sideLength: 5.2)
        print("The area of current square is \(square.area())")
        print(square.simpleDescription())
        print(square.simpleDescription(numberOfSides: 12))

        let equilateralTriangle = EquilateralTriangle(20, sideLength: 6.2)
        print(equilateralTriangle.simpleDescription())
        print("A equilateral triangle with sides of length \(equilateralTriangle.sideLength) and perimeter \(equilateralTriangle.perimeter).")
        equilateralTriangle.perimeter = 12.9
        print("A equilateral triangle with sides of length \(equilateralTriangle.sideLength) and perimeter \(equilateralTriangle.perimeter).")

        let triangleAndSquare = TriangleAndSquare(50, sideLength: 20.0)
        print(triangleAndSquare.square.sideLength)
        print(triangleAndSquare.triangle.sideLength)

        triangleAndSquare.square = Square(100, sideLength: 40.0)
        print(triangleAndSquare.triangle.sideLength)

        let optionalSquare: Square? = Square(60, sideLength: 20.0)
        let sideLength = optionalSquare?.sideLength
        print("A optional square with sides of length \(sideLength ?? 0.0).")
    }
}

class Shape: CustomStringConvertible {
    var numberOfSides: Int
    let numberOfCircles = 4

    /// 无参数构造方法
    init() {
        self.numberOfSides = 0
    }

    /// 有参数构造方法
    init(numberOfSides: Int) {
        self.numberOfSides = numberOfSides
    }

    /// 析构方法
    deinit {
        print(self.description)
    }

    /// 描述变量
    var description: String {
        "Shape(numberOfSides: \(numberOfSides), numberOfCircles: \(numberOfCircles))"
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }

    func simpleDescription(numberOfSides: Int) -> String {
        self.numberOfSides = numberOfSides
        return "A shape with \(numberOfSides) sides and \(numberOfCircles) circles." 
    }
}

class Square: Shape {
    var sideLength: Double

    init(_ numberOfSides: Int, sideLength: Double) {
        self.sideLength = sideLength
        super.init(numberOfSides: numberOfSides)
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    /// 重写方法
    override func simpleDescription() -> String {
        let superResult = super.simpleDescription()
        return "\(superResult) A square with sides of length \(sideLength)."
    }

    override func simpleDescription(numberOfSides: Int) -> String {
        let superResult = super.simpleDescription(numberOfSides: numberOfSides)
        return "\(superResult) A square with sides of length \(sideLength)."
    }
}

class EquilateralTriangle: Shape {
    var sideLength: Double = 0.0

    init(_ numberOfSides: Int, sideLength: Double) {
        self.sideLength = sideLength
        super.init(numberOfSides: numberOfSides)
    }

    /// 具有 getter 和 setter 的属性
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set (perimeterValue) {
            // 默认隐式名称为 newValue，这里定义了显示名称为 perimeterValue
            sideLength = perimeterValue / 3.0
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}

class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }

    var square: Square {
        // 不需要计算属性，但仍然需要提供在设置新值之前和之后运行的代码，请使用 willSet 和 didSet
        willSet {
            // 确保其三角形的边长始终与其正方形的边长相同
            triangle.sideLength = newValue.sideLength
        }
    }

    init(_ numberOfSides: Int, sideLength: Double) {
        square = Square(numberOfSides, sideLength: sideLength)
        triangle = EquilateralTriangle(numberOfSides, sideLength: sideLength)
    }
}