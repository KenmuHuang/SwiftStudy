//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 访问控制：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/26_access_control
class AccessControl: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        modulesAndSourceFiles()
        accessLevels()
        accessControlSyntax()
        customTypes()
        subclassing()
        constantsVariablesPropertiesSubscripts()
        initializers()
        protocols()
        extensions()
        generics()
        typeAliases()
    }
}

// MARK: - 模块和源文件
private func modulesAndSourceFiles() {
    /*
     Swift 中的访问控制模型基于模块和源文件这两个概念。

     模块指的是独立的代码单元，框架或应用程序会作为一个独立的模块来构建和发布。在 Swift 中，一个模块可以使用 import 关键字导入另外一个模块。

     在 Swift 中，Xcode 的每个 target（例如框架或应用程序）都被当作独立的模块处理。如果你是为了实现某个通用的功能，或者是为了封装一些常用方法而将代码打包成独立的框架，这个框架就是 Swift 中的一个模块。当它被导入到某个应用程序或者其他框架时，框架的内容都将属于这个独立的模块。

     源文件 就是 Swift 模块中的源代码文件（实际上，源文件属于一个应用程序或框架）。尽管我们一般会将不同的类型分别定义在不同的源文件中，但是同一个源文件也可以包含多个类型、函数等的定义。
     */
}

// MARK: - 访问级别
private func accessLevels() {
    /*
     Swift 为代码中的实体提供了五种不同的访问级别。这些访问级别不仅与源文件中定义的实体相关，同时也与源文件所属的模块相关。
     1、open 和 public 级别可以让实体被同一模块源文件中的所有实体访问，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，你会使用 open 或 public 级别来指定框架的外部接口。open 和 public 的区别在后面会提到。
     2、internal 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 internal 级别。
     3、fileprivate 限制实体只能在其定义的文件内部访问。如果功能的部分实现细节只需要在文件内使用时，可以使用 fileprivate 来将其隐藏。
     4、private 限制实体只能在其定义的作用域，以及同一文件内的 extension 访问。如果功能的部分细节只需要在当前作用域内使用时，可以使用 private 来将其隐藏。
     5、open 为最高访问级别（限制最少），private 为最低访问级别（限制最多）。

     open 只能作用于类和类的成员，它和 public 的区别主要在于 open 限定的类和成员能够在模块外能被继承和重写，在下面的 子类 这一节中有详解。将类的访问级别显式指定为 open 表明你已经设计好了类的代码，并且充分考虑过这个类在其他模块中用作父类时的影响。
     */
    // 访问级别基本原则
    /*
     Swift 中的访问级别遵循一个基本原则：实体不能定义在具有更低访问级别（更严格）的实体中。例如：
     1、一个 public 的变量，其类型的访问级别不能是 internal，fileprivate 或是 private。因为无法保证变量的类型在使用变量的地方也具有访问权限。
     2、函数的访问级别不能高于它的参数类型和返回类型的访问级别。因为这样就会出现函数可以在任何地方被访问，但是它的参数类型和返回类型却不可以的情况。
     */

    // 默认访问级别
    /*
     你代码中所有的实体，如果你不显式的指定它们的访问级别，那么它们将都有一个 internal 的默认访问级别，（有一些例外情况，本文稍后会有说明）。因此，多数情况下你不需要显示指定实体的访问级别。
     */

    // 单 target 应用程序的访问级别
    /*
     当你编写一个单 target 应用程序时，应用的所有功能都是为该应用服务，而不需要提供给其他应用或者模块使用，所以你不需要明确设置访问级别，使用默认的访问级别 internal 即可。但是，你也可以使用 fileprivate 或 private 访问级别，用于隐藏一些功能的实现细节。
     */

    // 框架的访问级别
    /*
     注意：框架的内部实现仍然可以使用默认的访问级别 internal，当你需要对框架内部其它部分隐藏细节时可以使用 private 或 fileprivate。对于框架的对外 API 部分，你就需要将它们设置为 open 或 public 了。
     */

    // 单元测试 target 的访问级别
    /*
     当你的应用程序包含单元测试 target 时，为了测试，测试模块需要访问应用程序模块中的代码。默认情况下只有 open 或 public 级别的实体才可以被其他模块访问。然而，如果在导入应用程序模块的语句前使用 @testable 特性，然后在允许测试的编译设置（Build Options -> Enable Testability）下编译这个应用程序模块，单元测试目标就可以访问应用程序模块中所有内部级别的实体。
     */
}

// MARK: - 访问控制语法
private func accessControlSyntax() {
    let somePublicVariable = SomePublicClass().somePublicVariable
    let someInternalConstant = SomeInternalClass().someInternalConstant
    let defaultInternalConstant = defaultInternalClass().defaultInternalConstant
    let someFilePrivateFunction = SomeFilePrivateClass().someFilePrivateFunction
    print("somePublicVariable = \(somePublicVariable), someInternalConstant = \(someInternalConstant), defaultInternalConstant = \(defaultInternalConstant)")
    someFilePrivateFunction()

    // private 不能被其他实体访问到，所以下面语句不能编译成功
//    let somePrivateFunction = SomePrivateClass().somePrivateFunction
}

public class SomePublicClass {
    public var somePublicVariable = 0
}

internal class SomeInternalClass {
    internal let someInternalConstant = 0
}

class defaultInternalClass {
    let defaultInternalConstant = 0
}

fileprivate class SomeFilePrivateClass {
    fileprivate func someFilePrivateFunction() {
        print("\(#function) in \(#fileID)[line: \(#line), column: \(#column)]")
    }
}

private class SomePrivateClass {
    private func somePrivateFunction() {

    }
}

// MARK: - 自定义类型
private func customTypes() {
    /*
     一个类型的访问级别也会影响到类型成员（属性、方法、构造器、下标）的默认访问级别。如果你将类型指定为 private 或者 fileprivate 级别，那么该类型的所有成员的默认访问级别也会变成 private 或者 fileprivate 级别。如果你将类型指定为 internal 或 public（或者不明确指定访问级别，而使用默认的 internal ），那么该类型的所有成员的默认访问级别将是 internal。
     */
    // 元组类型
    /*
     元组的访问级别将由元组中访问级别最严格的类型来决定。例如，如果你构建了一个包含两种不同类型的元组，其中一个类型为 internal，另一个类型为 private，那么这个元组的访问级别为 private。

     注意：元组不同于类、结构体、枚举、函数那样有单独的定义。一个元组的访问级别由元组中元素的访问级别来决定的，不能被显示指定。
     */

    // 函数类型
    /*
     函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定。但是，如果这种访问级别不符合函数定义所在环境的默认访问级别，那么就需要明确地指定该函数的访问级别。
     */
    let tuple = someFunction()
    print(tuple.0, tuple.1)

    // 枚举类型
    /*
     枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。
     枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。例如，你不能在一个 internal 的枚举中定义 private 的原始值类型。
     */

    // 嵌套类型
    /*
     嵌套类型的访问级别和包含它的类型的访问级别相同，嵌套类型是 public 的情况除外。在一个 public 的类型中定义嵌套类型，那么嵌套类型自动拥有 internal 的访问级别。如果你想让嵌套类型拥有 public 访问级别，那么必须显式指定该嵌套类型的访问级别为 public。
     */
}

fileprivate func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // 因为该函数返回类型的访问级别是 private，所以需要定义为 private 或 fileprivate
    return (SomeInternalClass(), SomePrivateClass())
}

// MARK: - 子类
private func subclassing() {
    /*
     你可以继承同一模块中的所有有访问权限的类，也可以继承不同模块中被 open 修饰的类。一个子类的访问级别不得高于父类的访问级别。例如，父类的访问级别是 internal，子类的访问级别就不能是 public。

     此外，在同一模块中，你可以在符合当前访问级别的条件下重写任意类成员（方法、属性、构造器、下标等）。在不同模块中，你可以重写类中被 open 修饰的成员。

     可以通过重写给所继承类的成员提供更高的访问级别。
     */
    let classB = B()
    classB.someFunction()
}

public class A {
    fileprivate func someFunction() {
        print("fileprivate someFunction")
    }
}

internal class B: A {
    internal override func someFunction() {
        super.someFunction()

        print("internal someFunction")
    }
}

// MARK: - 常量、变量、属性、下标
private func constantsVariablesPropertiesSubscripts() {
    /*
     常量、变量、属性不能拥有比它们的类型更高的访问级别。例如，你不能定义一个 public 级别的属性，但是它的类型却是 private 级别的。同样，下标也不能拥有比索引类型或返回类型更高的访问级别。

     如果常量、变量、属性、下标的类型是 private 级别的，那么它们必须明确指定访问级别为 private
     */
    // Getter 和 Setter
    /*
     Setter 的访问级别可以低于对应的 Getter 的访问级别，这样就可以控制变量、属性或下标的读写权限。在 var 或 subscript 关键字之前，你可以通过 fileprivate(set)，private(set) 或 internal(set) 为它们的写入权限指定更低的访问级别。

     注意：这个规则同时适用于存储型属性和计算型属性。即使你不明确指定存储型属性的 Getter 和 Setter，Swift 也会隐式地为其创建 Getter 和 Setter，用于访问该属性的存储内容。使用 fileprivate(set)，private(set) 和 internal(set) 可以改变 Setter 的访问级别，这对计算型属性也同样适用。
     */
    var stringToEdit = TrackedString()
    stringToEdit.value = "This string will be tracked."
    stringToEdit.value += " This edit will increment numberOfEdits."
    stringToEdit.value += " So will this one."
    print("The number of edits is \(stringToEdit.numberOfEdits)")
}

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

// MARK: - 构造器
private func initializers() {
    // 默认构造器
    /*
     如 默认构造器 所述，Swift 会为结构体和类提供一个默认的无参数的构造器，只要它们为所有存储型属性设置了默认初始值，并且未提供自定义的构造器。

     默认构造器的访问级别与所属类型的访问级别相同，除非类型的访问级别是 public。如果一个类型被指定为 public 级别，那么默认构造器的访问级别将为 internal。如果你希望一个 public 级别的类型也能在其他模块中使用这种无参数的默认构造器，你只能自己提供一个 public 访问级别的无参数构造器。
     */

    // 结构体默认的成员逐一构造器
    /*
     如果结构体中任意存储型属性的访问级别为 private，那么该结构体默认的成员逐一构造器的访问级别就是 private。否则，这种构造器的访问级别依然是 internal。

     如同前面提到的默认构造器，如果你希望一个 public 级别的结构体也能在其他模块中使用其默认的成员逐一构造器，你依然只能自己提供一个 public 访问级别的成员逐一构造器。
     */
}

// MARK: - 协议
private func protocols() {
    /*
     协议中的每个方法或属性都必须具有和该协议相同的访问级别。你不能将协议中的方法或属性设置为其他访问级别。这样才能确保该协议的所有方法或属性对于任意遵循者都可用。

     注意：如果你定义了一个 public 访问级别的协议，那么该协议的所有实现也会是 public 访问级别。这一点不同于其他类型，例如，类型是 public 访问级别时，其成员的访问级别却只是 internal。
     */
    // 协议继承
    /*
     如果定义了一个继承自其他协议的新协议，那么新协议拥有的访问级别最高也只能和被继承协议的访问级别相同。例如，你不能将继承自 internal 协议的新协议访问级别指定为 public 协议。
     */

    // 协议遵循
    /*
     遵循协议时的上下文级别是类型和协议中级别最小的那个。如果一个类型是 public 级别，但它要遵循的协议是 internal 级别，那么这个类型对该协议的遵循上下文就是 internal 级别。

     当你编写或扩展一个类型让它遵循一个协议时，你必须确保该类型对协议的每一个要求的实现，至少与遵循协议的上下文级别一致。例如，一个 public 类型遵循一个 internal 协议，这个类型对协议的所有实现至少都应是 internal 级别的。

     注意：Swift 和 Objective-C 一样，协议遵循是全局的，也就是说，在同一程序中，一个类型不可能用两种不同的方式实现同一个协议。
     */
}

// MARK: - Extension
private func extensions() {
    /*
     Extension 可以在访问级别允许的情况下对类、结构体、枚举进行扩展。Extension 的新增成员具有和原始类型成员一致的访问级别。例如，你使用 extension 扩展了一个 public 或者 internal 类型，则 extension 中的成员就默认使用 internal 访问级别。如果你使用 extension 扩展一个 fileprivate 类型，则 extension 中的成员默认使用 fileprivate 访问级别。如果你使用 extension 扩展了一个 private 类型，则 extension 的成员默认使用 private 访问级别。

     或者，你可以通过修饰语重新指定 extension 的默认访问级别（例如，private），从而给该 extension 中的所有成员指定一个新的默认访问级别。这个新的默认访问级别仍然可以被单独成员指定的访问级别所覆盖。

     如果你使用 extension 来遵循协议的话，就不能显式地声明 extension 的访问级别。extension 每个 protocol 要求的实现都默认使用 protocol 的访问级别。
     */
    // Extension 的私有成员
    SomeStruct().doSomething()
}

protocol SomeStructProtocol {
    func doSomething()
}

struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeStructProtocol {
    func doSomething() {
        print(privateVariable)
    }
}

// MARK: - 泛型
private func generics() {
    /*
     泛型类型或泛型函数的访问级别取决于泛型类型或泛型函数本身的访问级别，还需结合类型参数的类型约束的访问级别，根据这些访问级别中的最低访问级别来确定。
     */
}

// MARK: - 类型别名
private func typeAliases() {
    /*
     你定义的任何类型别名都会被当作不同的类型，以便于进行访问控制。类型别名的访问级别不可高于其表示的类型的访问级别。例如，private 级别的类型别名可以作为 private、fileprivate、internal、public 或者 open 类型的别名，但是 public 级别的类型别名只能作为 public 类型的别名，不能作为 internal、fileprivate 或 private 类型的别名。

     注意：这条规则也适用于为满足协议遵循而将类型别名用于关联类型的情况。
     */
}