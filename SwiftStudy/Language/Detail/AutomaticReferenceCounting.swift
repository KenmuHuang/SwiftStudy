//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 自动引用计数：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/24_automatic_reference_counting
class AutomaticReferenceCounting: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        howArcWorks()
        arcInAction()
        strongReferenceCyclesBetweenClassInstances()
        resolvingStrongReferenceCyclesBetweenClassInstances()
        strongReferenceCyclesForClosures()
        resolvingStrongReferenceCyclesForClosures()
    }
}

// MARK: - 自动引用计数的工作机制
private func howArcWorks() {
    /*
     注意：引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递。

     每当你创建一个新的类实例时，ARC 会分配一块内存来储存该实例的信息。内存中会包含实例的类型信息，以及这个实例所关联的任何存储属性的值。
     此外，当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的实例，不会一直占用内存空间。
     然而，当 ARC 回收并释放了正在被使用中的实例后，该实例的属性和方法将不能再被访问和调用。实际上，如果你试图访问这个实例，你的应用程序很可能会崩溃。
     为了确保使用中的实例不会被销毁，ARC 会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为 1，ARC 都不会销毁这个实例。
     为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。
     */
}

// MARK: - 自动引用计数实践
private func arcInAction() {
    var reference1: ARCPerson?
    var reference2: ARCPerson?
    var reference3: ARCPerson?

    reference1 = ARCPerson(name: "John Appleseed")
    reference2 = reference1
    reference2?.name = "Tom"
    reference3 = reference1
    print(reference3!.name)
}

class ARCPerson {
    var name: String
    var apartment: ARCApartment?

    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

// MARK: - 类实例之间的循环强引用
private func strongReferenceCyclesBetweenClassInstances() {
    /*
     如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。
     你可以通过定义类之间的关系为弱引用或无主引用，来替代强引用，从而解决循环强引用的问题。

     注意，当你把这两个变量设为 nil 时，没有任何一个析构器被调用。循环强引用会一直阻止 Person 和 Apartment 类实例的销毁，这就在你的应用程序中造成了内存泄漏。
     */
    var john: ARCPerson? = ARCPerson(name: "John Appleseed")
    var unit4A: ARCApartment? = ARCApartment(unit: "4A")
    john!.apartment = unit4A
    unit4A!.tenant = john

    john = nil
    if unit4A!.tenant == nil {
        print("The tenant of unit4A is auto set nil.")
    }
    unit4A = nil
}

class ARCApartment {
    let unit: String
//    var tenant: ARCPerson?
    weak var tenant: ARCPerson?

    init(unit: String) {
        self.unit = unit
        print("Apartment \(unit) is being initialized")
    }

    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

// MARK: - 解决实例之间的循环强引用
private func resolvingStrongReferenceCyclesBetweenClassInstances() {
    // 弱引用
    /*
     弱引用不会对其引用的实例保持强引用，因而不会阻止 ARC 销毁被引用的实例。这个特性阻止了引用变为循环强引用。声明属性或者变量时，在前面加上 weak 关键字表明这是一个弱引用。

     因为弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁。因此，ARC 会在引用的实例被销毁后自动将其弱引用赋值为 nil。并且因为弱引用需要在运行时允许被赋值为 nil，所以它们会被定义为可选类型变量，而不是常量。
     */

    // 无主引用
    /*
     无主引用通常都被期望拥有值。不过 ARC 无法在实例被销毁后将无主引用设为 nil，因为非可选类型的变量不允许被赋值为 nil。

     重点
     1、使用无主引用，你必须确保引用始终指向一个未销毁的实例。
     2、如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。

     注意：上面的例子展示了如何使用安全的无主引用。对于需要禁用运行时的安全检查的情况（例如，出于性能方面的原因），Swift 还提供了不安全的无主引用。与所有不安全的操作一样，你需要负责检查代码以确保其安全性。 你可以通过 unowned(unsafe) 来声明不安全无主引用。如果你试图在实例被销毁后，访问该实例的不安全无主引用，你的程序会尝试访问该实例之前所在的内存地址，这是一个不安全的操作。
     */
    var john: ARCCustomer? = ARCCustomer(name: "John Appleseed")
    john!.card = ARCCreditCard(number: 1234_5678_9012_3456, customer: john!)

    john = nil

    // 无主引用和隐式解包可选值属性
    // 加拿大「国家」的「首都」是渥太华
    let country = ARCCountry(name: "Canada", capitalName: "Ottawa")
    print("\(country.name)'s capital city is called \(country.capitalCity.name)")
}

class ARCCustomer {
    var name: String
    var card: ARCCreditCard?

    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

class ARCCreditCard {
    let number: UInt64
    unowned let customer: ARCCustomer

    init(number: UInt64, customer: ARCCustomer) {
        self.number = number
        self.customer = customer
        print("Card #\(number) is being initialized")
    }

    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

class ARCCountry {
    let name: String
    var capitalCity: ARCCity!

    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = ARCCity(name: capitalName, country: self)
        print("Country \(name) include capital city \(capitalCity.name) is being initialized")
    }

    deinit {
        print("Country \(name) include capital city \(capitalCity.name) is being deinitialized")
    }
}

class ARCCity {
    let name: String
    unowned let country: ARCCountry

    init(name: String, country: ARCCountry) {
        self.name = name
        self.country = country
        print("City \(name) is being initialized")
    }

    deinit {
        // Fatal error: Attempted to read an unowned reference but object 0x600001736af0 was already deallocated
//        print("City \(name) of country \(country.name) is being deinitialized")
        print("City \(name) is being deinitialized")
    }
}

// MARK: - 闭包的循环强引用
private func strongReferenceCyclesForClosures() {
    /*
     循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。这个闭包体中可能访问了实例的某个属性，例如 self.someProperty，或者闭包中调用了实例的某个方法，例如 self.someMethod()。这两种情况都导致了闭包“捕获”self，从而产生了循环强引用。

     循环强引用的产生，是因为闭包和类相似，都是引用类型。当你把一个闭包赋值给某个属性时，你是将这个闭包的引用赋值给了属性。实质上，这跟之前的问题是一样的——两个强引用让彼此一直有效。但是，和两个类实例不同，这次一个是类实例，另一个是闭包。

     Swift 提供了一种优雅的方法来解决这个问题，称之为 闭包捕获列表（closure capture list）。同样的，在学习如何用闭包捕获列表打破循环强引用之前，先来了解一下这里的循环强引用是如何产生的，这对我们很有帮助。
     */
    var span: HTMLElement? = HTMLElement(name: "span", text: "HTML Element")
    print(span!.asHTML())

    // span = nil 此时 asHTML 属性为闭包循环强引用，不会被销毁
    span = nil

    span = HTMLElement(name: "span")
    span!.asHTML = {
        "<\(span!.name) title='redefine closure'>\(span!.text ?? "some default text")<\(span!.name)/>"
    }
    print(span!.asHTML())

    // span = nil 此时 asHTML 属性为闭包没有持有 self，会被销毁
    span = nil
}

class HTMLElement {
    let name: String
    let text: String?

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
        print("HTMLElement \(name) is being initialized")
    }

    deinit {
        print("HTMLElement \(name) is being deinitialized")
    }

    /// 注意：asHTML 声明为 lazy 属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用 asHTML。也就是说，在默认的闭包中可以使用 self，因为只有当初始化完成以及 self 确实存在后，才能访问 lazy 属性。
    lazy var asHTML: () -> String = {
        if let text = self.text {
            // 注意：虽然闭包多次使用了 self，它只捕获 HTMLElement 实例的一个强引用。
            return "<\(self.name)>\(text)<\(self.name)/>"
        } else {
            return "<\(self.name) />"
        }
    }

    lazy var asContent: () -> String = {
        [unowned self] in
        if let text = self.text {
            // 注意：虽然闭包多次使用了 self，它只捕获 HTMLElement 实例的一个强引用。
            return "{\(self.name)}\(text){\(self.name)/}"
        } else {
            return "{\(self.name) /}"
        }
    }
}

// MARK: - 解决闭包的循环强引用
private func resolvingStrongReferenceCyclesForClosures() {
    /*
     在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
     捕获列表中的每一项都由一对元素组成，一个元素是 weak 或 unowned 关键字，另一个元素是类实例的引用（例如 self）或初始化过的变量（如 delegate = self.delegate）。这些项在方括号中用逗号分开。
     注意：如果被捕获的引用绝对不会变为 nil，应该用无主引用，而不是弱引用。
     */
    // 定义捕获列表
//    lazy var someClosure = {
//        [unowned self, weak delegate = self.delegate]
//        (index: Int, stringToProcess: String) -> String in
//        // 这里是闭包的函数体
//    }
//
//    lazy var someClosure = {
//        [unowned self, weak delegate = self.delegate] in
//        // 这里是闭包的函数体
//    }

    // 弱引用和无主引用
    var span: HTMLElement? = HTMLElement(name: "span", text: "HTML Element")
    print(span!.asContent())

    // span = nil 此时 asContent 使用捕获列表是 [unowned self]，表示“将 self 捕获为无主引用而不是强引用”，会被销毁
    span = nil
}