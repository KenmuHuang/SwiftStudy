//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 字符串和字符：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/03_strings_and_characters
class StringsAndCharacters: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        // 字符串字面量
        let quotation = """
        The White Rabbit put on his spectacles.  "Where shall I begin,
        please your Majesty?" he asked.
        ​
        "Begin at the beginning," the King said gravely, "and go on
        till you come to the end; then stop."
        """
        
        let singleLineString = "These are the same."
        let multilineString = """
        These are the same.
        """
        
        let softWrappedQuotation = """
        The White Rabbit put on his spectacles.  "Where shall I begin, \
        please your Majesty?" he asked.
        ​
        "Begin at the beginning," the King said gravely, "and go on \
        till you come to the end; then stop."
        """
        
        
        // 字符串字面量的特殊字符
        // "Imageination is more important than knowledge" - Enistein
        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        // $，Unicode 标量 U+0024
        let dollarSign = "\u{24}"
        // ♥，Unicode 标量 U+2665
        let blackHeart = "\u{2665}"
        // 💖，Unicode 标量 U+1F496
        let sparklingHeart = "\u{1F496}"
        
        
        // 扩展字符串分隔符
        var lineString = "Line 1 \nLine 2"
        lineString = #"Line 1 \nLine 2"#
        
        
        // 初始化空字符串
        var emptyString = ""
        var anotherEmptyString = String()
        if emptyString.isEmpty &&
            emptyString == anotherEmptyString {
            print("Nothing to see here")
        }
        
        
        // 字符串可变性
        // 在 Objective-C 和 Cocoa 中，需要通过选择两个不同的类（NSString 和 NSMutableString）来指定字符串是否可以被修改。Swift 能直接拼接
        var variableString = "Horse"
        variableString += " and carriage"
        variableString.append("!!!")
        
        let goodStart = """
        one
        two

        """
        let end = """
        three
        """
        print(goodStart + end)
        
        
        // 使用字符
        for character in "Dog!🐶" {
            print(character)
        }
        
        let exclamationMark: Character = "!"
        let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
        print(String(catCharacters))
        
        
        // 字符串插值
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        
        // 打印 "Write an interpolated string in Swift using \(multiplier)."
        print(#"Write an interpolated string in Swift using \(multiplier)."#)
        
        // 打印 "6 times 7 is 42."
        print(#"6 times 7 is \#(6 * 7)."#)
        
        
        // Unicode
        let precomposed: Character = "\u{D55C}"
        let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"
        let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
        if precomposed == decomposed {
            print(precomposed)
        }
        
        
        // 计算字符数量
        let unusualMenagerie = "Koala 🐨"
        print("unusualMenagerie has \(unusualMenagerie.count) characters")
        
        var word = "cafe"
        print("the number of characters in \(word) is \(word.count)")
        
        // 拼接一个重音，U+0301，最终这个字符串的字符数量仍然是 4，因为第四个字符是 é，而不是 e
        word += "\u{301}"
        print("the number of characters in \(word) is \(word.count)")
        
        
        // 访问和修改字符串
        // 不同的字符可能会占用不同数量的内存空间，所以要知道 Character 的确定位置，就必须从 String 开头遍历每一个 Unicode 标量直到结尾。因此，Swift 的字符串不能用整数（integer）做索引
        let greeting = "Guten Tag!"
        var element = greeting[greeting.startIndex]
        element = greeting[greeting.index(before: greeting.endIndex)]
        element = greeting[greeting.index(after: greeting.startIndex)]
        element = greeting[greeting.index(greeting.startIndex, offsetBy: 7)]
        print(element)
        
        for index in greeting.indices {
            print("\(greeting[index])", terminator: "")
        }
        print("")
        
        // 插入和删除
        var welcome = "hello"
        welcome.insert(" ", at: welcome.endIndex)
        welcome.insert(contentsOf: "world!", at: welcome.endIndex)
        welcome.insert(contentsOf: ", Kenmu", at: welcome.index(before: welcome.endIndex))
        
        welcome.remove(at: welcome.index(before: welcome.endIndex))
        
        let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)
        
        
        // 子字符串
        welcome = "Hello, world!"
        let index = welcome.firstIndex(of: ",") ?? welcome.endIndex
        let beginning = welcome[..<index]
        let newString = String(beginning)
        
        
        // 前缀/后缀相等
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]
        var act1SceneCount = 0
        var cellCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1 ") {
                act1SceneCount += 1
            }
            if scene.hasSuffix("cell") {
                cellCount += 1
            }
        }
        print("There are \(act1SceneCount) scenes in Act 1, \(cellCount) cells.")
        
        
        // 字符串的 Unicode 表示形式
        let dogString = "Dog‼🐶"
        // 划分：68 + 111 + 103 + 226 128 188 + 240 159 144 182
        // 打印：68 111 103 226 128 188 240 159 144 182
        for codeUnit in dogString.utf8 {
            print("\(codeUnit) ", terminator: "")
        }
        print("")
        
        // 划分：68 + 111 + 103 + 8252 + 55357 56374
        // 打印：68 111 103 8252 55357 56374
        for codeUnit in dogString.utf16 {
            print("\(codeUnit) ", terminator: "")
        }
        print("")
        
        // 打印：68(D) 111(o) 103(g) 8252(‼) 128054(🐶)
        for scalar in dogString.unicodeScalars {
            print("\(scalar.value)(\(scalar)) ", terminator: "")
        }
        print("")
    }
}
