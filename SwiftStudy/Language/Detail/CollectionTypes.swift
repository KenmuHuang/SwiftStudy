//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 集合类型：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/04_collection_types
class CollectionTypes: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        // 数组（Arrays）
        // 创建一个空数组
        var someInts = [Int]()
        print("someInts is of type [Int] with \(someInts.count) items.")
        someInts.append(3)
        someInts = []


        // 创建一个带有默认值的数组
        var threeDoubles = Array(repeating: 0.0, count: 3)
        var anotherThreeDoubles = Array(repeating: 2.5, count: 3)


        // 通过两个数组相加创建一个数组
        var sixDoubles = threeDoubles + anotherThreeDoubles


        // 用数组字面量构造数组
        var shoppingList = ["Eggs", "Milk"]


        // 访问和修改数组
        if shoppingList.isEmpty {
            print("The shopping list is empty.")
        } else {
            print("The shopping list is not empty.")
        }

        shoppingList.append("Flour")
        shoppingList += ["Baking powder"]
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

        var firstItem = shoppingList[0]
        firstItem = shoppingList.first ?? ""
        shoppingList[0] = "Six eggs"

        shoppingList[4...6] = ["Bananas", "Apples"]

        shoppingList.insert("Maple Syrup", at: 0)

        let mapleSyrup = shoppingList.remove(at: 0)
        firstItem = shoppingList[0]

        let sixEggs = shoppingList.removeFirst()
        firstItem = shoppingList[0]

        let apples = shoppingList.removeLast()
        print("shoppingList = \(shoppingList), shoppingList.count = \(shoppingList.count)")


        // 数组的遍历
        for item in shoppingList {
            print(item, terminator: ", ")
        }
        print("")

        for (index, value) in shoppingList.enumerated() {
            print("Item \(index + 1): \(value)")
        }


        // 集合（Sets）
        // 创建和构造一个空的集合
        var letters = Set<Character>()
        letters.insert("a")
        letters = []


        // 用数组字面量创建集合
//        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]


        // 访问和修改一个集合
        if favoriteGenres.isEmpty {
            print("As far as music goes, I'm not picky.")
        } else {
            print("I have \(favoriteGenres.count) favorite music genres.")
        }

        favoriteGenres.insert("Jazz")

        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }

        if favoriteGenres.contains("Funk") {
            print("I get up on the good foot.")
        } else {
            print("It's too funky in here.")
        }


        // 遍历一个集合
        for genre in favoriteGenres {
            print(genre, terminator: ", ")
        }
        print("")

        for genre in favoriteGenres.sorted() {
            print(genre, terminator: ", ")
        }
        print("")


        // 基本集合操作
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

        // 使用 union(_:) 方法根据两个集合的所有值创建一个新的集合
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.union(evenDigits).sorted()

        // 使用 intersection(_:) 方法根据两个集合的交集创建一个新的集合
        // []
        oddDigits.intersection(evenDigits).sorted()

        // 使用 subtracting(_:) 方法根据不在另一个集合中的值创建一个新的集合
        // [1, 9]
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()

        // 使用 symmetricDifference(_:) 方法根据两个集合不相交的值创建一个新的集合
        // [1, 2, 9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()


        // 集合成员关系和相等
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        let feedAnimals: Set = ["🐱", "🐶"]

        // 使用 isSubset(of:) 方法来判断一个集合中的所有值是否也被包含在另外一个集合中
        // true
        houseAnimals.isSubset(of: farmAnimals)

        // 使用 isSuperset(of:) 方法来判断一个集合是否包含另一个集合中所有的值
        // true
        farmAnimals.isSuperset(of: houseAnimals)

        // 使用 isDisjoint(with:) 方法来判断两个集合是否不含有相同的值（是否没有交集）
        // true
        farmAnimals.isDisjoint(with: cityAnimals)

        // 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等
        // true, false, false
        houseAnimals.isSubset(of: feedAnimals)
        houseAnimals.isStrictSubset(of: feedAnimals)
        houseAnimals.isStrictSuperset(of: feedAnimals)

        // 使用“是否相等”运算符（==）来判断两个集合包含的值是否全部相同
        // true
        houseAnimals == feedAnimals


        // 字典（Dictionaries）
        // 创建一个空字典
        var namesOfIntegers = [Int: String]()

        namesOfIntegers[16] = "sixteen"
        namesOfIntegers = [:]

        // 用字典字面量创建字典
        var airports = [
            "YYZ": "Toronto Pearson",
            "DUB": "Dublin"
        ]

        // 访问和修改字典
        airports["LHR"] = "London"
        airports["LHR"] = "London Heathrow"

        if airports.isEmpty {
            print("The airports dictionary is empty.")
        } else {
            print("The airports dictionary is not empty, which contains \(airports.count) item.")
        }

        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).");
        }

        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }

        airports["APL"] = "Apple Internation"
        airports["APL"] = nil

        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        print(airports)

        // 字典遍历
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }

        for airportCode in airports.keys.sorted() {
            print("Airport code: \(airportCode)")
        }

        for airportName in airports.values.sorted() {
            print("Airport name: \(airportName)")
        }

        let airportCodes = [String](airports.keys)
        let airportNames = [String](airports.values)
    }
}