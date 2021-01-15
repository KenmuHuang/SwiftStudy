//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 类型转换：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/18_type_casting
class TypeCasting: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        classHierarchyForTypeCasting()
        checkingType()
        downCasting()
        typeCastingForAnyAndAnyObject()
    }

    // MARK: - 为类型转换定义类层次
    private func classHierarchyForTypeCasting() {
        print("library.count = \(library.count)")
    }

    ///
    /// 数字媒体项类
    class MediaItem {
        /// 名称
        var name: String

        init(name: String) {
            self.name = name
        }
    }

    ///
    /// 电影类
    class Movie: MediaItem {
        /// 导演
        var director: String

        init(name: String, director: String) {
            self.director = director

            super.init(name: name)
        }
    }

    class Song: MediaItem {
        /// 艺术家
        var artist: String

        init(name: String, artist: String) {
            self.artist = artist

            super.init(name: name)
        }
    }

    /// 媒体库数组，类型被推断为 [MediaItem]
    let library = [
        Movie(name: "Casablanca", director: "Michael Curtiz"),
        Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
        Movie(name: "Citizen Kane", director: "Orson Welles"),
        Song(name: "The One And Only", artist: "Chesney Hawkes"),
        Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
    ]

    // MARK: - 检查类型
    private func checkingType() {
        var movieCount = 0
        var songCount = 0

        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        print("Media library contains \(movieCount) movies and \(songCount) songs")


        var movieIndexList = [Int]()
        var songIndexList = [Int]()
        for index in 0..<library.count {
            let item = library[index]
            if item is Movie {
                movieIndexList.append(index)
            } else if item is Song {
                songIndexList.append(index)
            }
        }
        print("Media library contains \(movieIndexList.count) movies and \(songIndexList.count) songs")
    }

    // MARK: - 向下转型
    private func downCasting() {
        for item in library {
            if let movie = item as? Movie {
                /*
                 当你不确定向下转型可以成功时，用类型转换的条件形式（as?）。条件形式的类型转换总是返回一个可选值，并且若下转是不可能的，可选值将是 nil。这使你能够检查向下转型是否成功
                 */
                print("Movie: \(movie.name), dir. \(movie.director)")
            } else if item is Song {
                /*
                 只有你可以确定向下转型一定会成功时，才使用强制形式（as!）。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误
                 */
                let song = item as! Song
                print("Song: \(song.name), by \(song.artist)")
            }
        }
    }

    // MARK: - Any 和 AnyObject 的类型转换
    private func typeCastingForAnyAndAnyObject() {
        /*
         Swift 为不确定类型提供了两种特殊的类型别名：
         1、Any 可以表示任何类型，包括函数类型
         2、AnyObject 可以表示任何类类型的实例
         */
        var things = [Any]()
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({ (name: String) -> String in "Hello, \(name)" })

        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called \(movie.name), dir. \(movie.director)")
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
        }

        /*
         注意：Any 类型可以表示所有类型的值，包括可选类型。Swift 会在你用 Any 类型来表示一个可选值的时候，给你一个警告。如果你确实想使用 Any 类型来承载可选值，你可以使用 as 操作符显式转换为 Any
         */
        let optionalNumber: Int? = 3
        // 警告
        things.append(optionalNumber)

        // 没有警告
        things.append(optionalNumber as Any)
    }
}