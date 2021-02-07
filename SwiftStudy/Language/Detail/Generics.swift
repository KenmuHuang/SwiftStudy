//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 泛型：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/22_generics
class Generics: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        theProblemThatGenericsSolve()
        genericFunctions()
        typeParameters()
        namingTypeParameters()
        genericTypes()
        extendingAGenericType()
        typeConstraints()
        associatedTypes()
        whereClauses()
        extensionsWithAGenericWhereClause()
        contextualWhereClauses()
        associatedTypesWithAGenericWhereClause()
        genericSubscripts()
    }
}

// MARK: - 泛型解决的问题
private func theProblemThatGenericsSolve() {
    /*
     swapTwoInts(_:_:)、swapTwoStrings(_:_:) 和 swapTwoDoubles(_:_:) 函数体是一样的，唯一的区别是它们接受的参数类型（Int、String 和 Double）。
     在实际应用中，通常需要一个更实用更灵活的函数来交换两个任意类型的值，幸运的是，泛型代码帮你解决了这种问题。

     注意：在三个函数中，a 和 b 类型必须相同。如果 a 和 b 类型不同，那它们俩就不能互换值。Swift 是类型安全的语言，所以它不允许一个 String 类型的变量和一个 Double 类型的变量互换值。试图这样做将导致编译错误。
     */
    var someInt = 3
    var anotherInt = 107
    swapTwoInts(&someInt, &anotherInt)
    print("The someInt is now \(someInt), and the anotherInt is now \(anotherInt)")
}

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// MARK: - 泛型函数
private func genericFunctions() {
    /*
     注意：定义的 swapTwoValues(_:_:) 函数是受 swap(_:_:) 函数启发而实现的。后者存在于 Swift 标准库，你可以在你的应用程序中使用它。如果你在代码中需要类似 swapTwoValues(_:_:) 函数的功能，你可以使用已存在的 swap(_:_:) 函数。
     */
    var someInt = 3
    var anotherInt = 107
    swapTwoValues(&someInt, &anotherInt)
    print("The someInt is now \(someInt), and the anotherInt is now \(anotherInt)")

    var someString = "hello"
    var anotherString = "world"
    swapTwoValues(&someString, &anotherString)
    print("The someString is now \(someString), and the anotherString is now \(anotherString)")
}

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// MARK: - 类型参数
private func typeParameters() {
    /*
     swapTwoValues(_:_:) 例子中，占位类型 T 是一个类型参数的例子，类型参数指定并命名一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来（例如 <T>）。

     一旦一个类型参数被指定，你可以用它来定义一个函数的参数类型（例如 swapTwoValues(_:_:) 函数中的参数 a 和 b），或者作为函数的返回类型，还可以用作函数主体中的注释类型。在这些情况下，类型参数会在函数调用时被实际类型所替换。（在上面的 swapTwoValues(_:_:) 例子中，当函数第一次被调用时，T 被 Int 替换，第二次调用时，被 String 替换。）

     你可提供多个类型参数，将它们都写在尖括号中，用逗号分开。
     */
}

// MARK: - 命名类型参数
private func namingTypeParameters() {
    /*
     大多情况下，类型参数具有描述下的名称，例如字典 Dictionary<Key, Value> 中的 Key 和 Value 及数组 Array<Element> 中的 Element，这能告诉阅读代码的人这些参数类型与泛型类型或函数之间的关系。然而，当它们之间没有有意义的关系时，通常使用单个字符来表示，例如 T、U、V，例如上面演示函数 swapTwoValues(_:_:) 中的 T。

     注意：请始终使用大写字母开头的驼峰命名法（例如 T 和 MyTypeParameter）来为类型参数命名，以表明它们是占位类型，而不是一个值。
     */
}

// MARK: - 泛型类型
private func genericTypes() {
    /*
     除了泛型函数，Swift 还允许自定义泛型类型。这些自定义类、结构体和枚举可以适用于任意类型，类似于 Array 和 Dictionary。

     注意：Stack 基本上和 IntStack 相同，只是用占位类型参数 Element 代替了实际的 Int 类型。这个类型参数包裹在紧随结构体名的一对尖括号里（<Element>）。
     Element 为待提供的类型定义了一个占位名。这种待提供的类型可以在结构体的定义中通过 Element 来引用。在这个例子中，Element 在如下三个地方被用作占位符：
     1、创建 items 属性，使用 Element 类型的空数组对其进行初始化。
     2、指定 push(_:) 方法的唯一参数 item 的类型必须是 Element 类型。
     3、指定 pop() 方法的返回值类型必须是 Element 类型。
     */
    var stackOfInts = IntStack()
    stackOfInts.push(1)
    stackOfInts.push(3)
    stackOfInts.push(5)
    let firstPopInt = stackOfInts.pop()
    print("The firstPopInt is now \(firstPopInt), the stackOfInts is now \(stackOfInts)")

    var stackOfStrings = Stack<String>()
    stackOfStrings.push("first push")
    stackOfStrings.push("second push")
    stackOfStrings.push("third push")
    let firstPopString = stackOfStrings.pop()
    print("The firstPopString is now \(firstPopString), the stackOfStrings is now \(stackOfStrings)")
}

struct IntStack {
    var items = [Int]()

    mutating func push(_ item: Int) {
        items.append(item)
    }

    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items = [Element]()

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element {
        return items.removeLast()
    }
}

// MARK: - 泛型扩展
private func extendingAGenericType() {
    var stackOfInts = Stack<Int>()
    stackOfInts.push(1)
    stackOfInts.push(3)
    stackOfInts.push(5)
    let firstPopInt = stackOfInts.pop()
    print("The firstPopInt is now \(firstPopInt), the stackOfInts is now \(stackOfInts)")

    if let topItem = stackOfInts.topItem {
        print("The top item on the stack is \(topItem).")
    }
}

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// MARK: - 类型约束
private func typeConstraints() {
    /*
     在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束。下面将展示泛型函数约束的基本语法（与泛型类型的语法相同）
     */
    // 类型约束语法

    // 类型约束实践
    if let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25]) {
        print("The doubleIndex is \(doubleIndex)")
    }

    if let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"]) {
        print("The stringIndex is \(stringIndex)")
    }
}

func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// MARK: - 关联类型
private func associatedTypes() {
    /*
     定义一个协议时，声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位符名称，其代表的实际类型在协议被遵循时才会被指定。关联类型通过 associatedtype 关键字来指定。
     */

    // 关联类型实践
    /*
     由于 Swift 的类型推断，实际上在 StringStack 的定义中不需要声明 Item 为 String。因为 StringStack 符合 Container 协议的所有要求，Swift 只需通过 append(_:) 方法的 item 参数类型和下标返回值的类型，就可以推断出 Item 的具体类型。事实上，如果你在上面的代码中删除了 typealias Item = String 这一行，一切也可正常工作，因为 Swift 清楚地知道 Item 应该是哪种类型。
     */
    var stackOfStrings = StringStack()
    stackOfStrings.append("first push")
    stackOfStrings.append("second push")
    stackOfStrings.append("third push")
    let firstPopString = stackOfStrings.pop()
    print("The firstPopString is now \(firstPopString), the stackOfStrings is now \(stackOfStrings), the count of stackOfStrings is now \(stackOfStrings.count), the first element of stackOfStrings is now \"\(stackOfStrings[0])\"")

    // 扩展现有类型来指定关联类型
    /*
     Swift 的 Array 类型已经提供 append(_:) 方法，count 属性，以及带有 Int 索引的下标来检索其元素。这三个功能都符合 Container 协议的要求，也就意味着你只需声明 Array 遵循Container 协议，就可以扩展 Array，使其遵从 Container 协议。你可以通过一个空扩展来实现这点，正如通过扩展采纳协议中的描述：
     */

    // 给关联类型添加约束
    /*
     你可以在协议里给关联类型添加约束来要求遵循的类型满足约束。例如，下面的代码定义了 Container 协议， 要求关联类型 Item 必须遵循 Equatable 协议
     */

    // 在关联类型约束里使用协议
    /*
     在这个协议里，Suffix 是一个关联类型，就像上边例子中 Container 的 Item 类型一样。Suffix 拥有两个约束：它必须遵循 SuffixableContainer 协议（就是当前定义的协议），以及它的 Item 类型必须是和容器里的 Item 类型相同。Item 的约束是一个 where 分句，它在下面 具有泛型 Where 子句的扩展 中有讨论。
     */
    var stackOfInts = Stack<Int>()
    stackOfInts.append(10)
    stackOfInts.append(20)
    stackOfInts.append(30)
    let suffix = stackOfInts.suffix(2)
    print("The suffix is now \(suffix)")

    let suffixStackOfStrings = stackOfStrings.suffix(2)
    print("The suffixStackOfStrings is now \(suffixStackOfStrings)")
}

protocol Container {
    // associatedtype Item: Equatable
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct StringStack: Container {
    var items = [String]()

    mutating func push(_ item: String) {
        items.append(item)
    }

    mutating func pop() -> String {
        return items.removeLast()
    }

    // Container 协议的实现部分，就算注释 typealias Item = String 也正常，Swift 只需通过 append(_:) 方法的 item 参数类型和下标返回值的类型，就可以推断出 Item 的具体类型
//    typealias Item = String

    mutating func append(_ item: String) {
        self.push(item)
    }

    var count: Int {
        return items.count
    }

    subscript(i: Int) -> String {
        return items[i]
    }
}

extension Array: Container {
}

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    // Container 协议的实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }

    var count: Int {
        return items.count
    }

    subscript(i: Int) -> Element {
        return items[i]
    }

    // SuffixableContainer 协议的实现部分
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
}

extension StringStack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack<String> {
        var result = Stack<String>()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
}

// MARK: - 泛型 Where 语句
private func whereClauses() {
    /*
     类型约束 让你能够为泛型函数、下标、类型的类型参数定义一些强制要求。
     对关联类型添加约束通常是非常有用的。你可以通过定义一个泛型 where 子句来实现。通过泛型 where 子句让关联类型遵从某个特定的协议，以及某个特定的类型参数和关联类型必须类型相同。你可以通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的相等关系。你可以在函数体或者类型的大括号之前添加 where 子句。
     */
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")

    let arrayOfStrings = ["uno", "dos", "tres"]

    if allItemsMatch(stackOfStrings, arrayOfStrings) {
        print("All items match.")
    } else {
        print("Not all items match.")
    }
}

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
    // 检查两个容器含有相同数量的元素
    if someContainer.count != anotherContainer.count {
        return false
    }

    // 检查每一对元素是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }

    return true
}

// MARK: - 具有泛型 Where 子句的扩展
private func extensionsWithAGenericWhereClause() {
    /*
     如果尝试在其元素不符合 Equatable 协议的栈上调用 isTop(_:) 方法，则会收到编译时错误。
     */
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")

    var element = "tres"
    if stackOfStrings.isTop(element) {
        print("Top element is \(element).")
    } else {
        print("Top element is something else.")
    }

    element = "uno"
    if stackOfStrings.startsWith(element) {
        print("\(stackOfStrings) starts with \(element).")
    } else {
        print("\(stackOfStrings) starts with something else.")
    }

    print([1260.0, 1200.0, 98.6, 37.0].average())
}

///
/// 扩展了泛型 Stack 结构体，只要容器的元素是符合 Equatable 协议的
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            // 这个栈是空时，返回 false
            return false
        }

        return topItem == item
    }
}

///
/// 扩展了 Container 协议，只要容器的元素是符合 Equatable 协议的
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

///
/// 扩展了 Container 协议，要求 Item 为特定类型
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}

// MARK: - 包含上下文关系的 where 分句
private func contextualWhereClauses() {
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")

    let element = "tres"
    if stackOfStrings.endsWith(element) {
        print("\(stackOfStrings) ends with \(element).")
    } else {
        print("\(stackOfStrings) ends with something else.")
    }

    print([1260.0, 1200.0, 98.6, 37.0].maximum())
}

extension Container {
    func endsWith(_ item: Item) -> Bool
        where Item: Equatable {
        return count >= 1 && self[count - 1] == item
    }

    func maximum() -> Double
        where Item == Double {
        var max = 0.0
        for index in 0..<count {
            let element = self[index]
            if element > max {
                max = element
            }
        }
        return max
    }
}

// MARK: - 具有泛型 Where 子句的关联类型
private func associatedTypesWithAGenericWhereClause() {
    /*
     迭代器（Iterator）的泛型 where 子句要求：无论迭代器是什么类型，迭代器中的元素类型，必须和容器项目的类型保持一致。makeIterator() 则提供了容器的迭代器的访问接口。

     一个协议继承了另一个协议，你通过在协议声明的时候，包含泛型 where 子句，来添加了一个约束到被继承协议的关联类型。例如，下面的代码声明了一个 ComparableContainer 协议，它要求所有的 Item 必须是 Comparable 的。
     */
}

protocol IteratorContainer {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }

    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

protocol ComparableContainer: IteratorContainer where Item: Comparable {
}

// MARK: - 泛型下标
private func genericSubscripts() {
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")

    let selectedIndices = [0, 2, 6]
    let selectedElements = stackOfStrings[selectedIndices]
    print("The selected elements are \(selectedElements).")
}

extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
    where Indices.Iterator.Element == Int {
        var result = [Item]()
        for index in indices {
            if index < count {
                result.append(self[index])
            }
        }
        return result
    }
}