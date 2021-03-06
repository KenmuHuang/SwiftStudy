//
// Created by KenmuHuang on 2020/8/19.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import Foundation

///
/// 可选链：https://swiftgg.gitbook.io/swift/swift-jiao-cheng/16_optional_chaining
class OptionalChaining: MainProtocol {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        asAnAlternativeToForcedUnwrapping()
        definingModelClasses()
        accessingProperties()
        callingMethods()
        accessingSubscripts()
        linkingMultipleLevels()
        onMethodsWithOptionalReturnValues()
    }

    // MARK: - 使用可选链式调用代替强制解包
    private func asAnAlternativeToForcedUnwrapping() {
        let john = Person()

        // 如果使用叹号（!）强制解包获得这个 john 的 residence 属性中的 numberOfRooms 值，会触发运行时错误，因为这时 residence 没有可以解包的值
//        let roomCount = john.residence!.numberOfRooms

        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }

        var roomCount = john.residence?.numberOfRooms
        print("roomCount = \(roomCount ?? 0)")

        john.residence = Residence()
        roomCount = john.residence?.numberOfRooms
        print("roomCount = \(roomCount ?? 0)")
    }

    ///
    /// 住宅类
    class Residence {
        var rooms = [Room]()
        var address: Address?

        var numberOfRooms: Int {
            return rooms.count
        }

        subscript(index: Int) -> Room {
            get {
                return rooms[index]
            }
            set(newValue) {
                rooms[index] = newValue
            }
        }

        func printNumberOfRooms() {
            print("The number of rooms is \(numberOfRooms)")
        }
    }

    ///
    /// 人类
    class Person {
        var residence: Residence?
    }

    // MARK: - 为可选链式调用定义模型类
    private func definingModelClasses() {

    }

    ///
    /// 房间类
    class Room {
        let name: String

        init(name: String) {
            self.name = name
        }
    }

    ///
    /// 地址类
    class Address {
        var buildingName: String?
        var buildingNumber: String?
        var street: String?

        func buildingIdentifier() -> String? {
            if buildingName != nil {
                return buildingName
            } else if let buildingNumber = buildingNumber, let street = street {
                return "\(buildingNumber) \(street)"
            } else {
                return nil
            }
        }
    }

    // MARK: - 通过可选链式调用访问属性
    private func accessingProperties() {
        let john = Person()
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }

        // 使用一个函数来创建 Address 实例，然后将该实例返回用于赋值。该函数会在返回前打印“Function was called”，这使你能验证等号右侧的代码是否被执行
        // john.residence 为 nil 对应可选链式调用失败时，等号右侧的代码不会被执行
        john.residence?.address = createAddress()
    }

    func createAddress() -> Address {
        print("Function of createAddress was called.")

        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        return someAddress
    }

    // MARK: - 通过可选链式调用来调用方法
    private func callingMethods() {
        let john = Person()
        john.residence = Residence()

        // 如果在可选值上通过可选链式调用来调用这个方法，该方法的返回类型会是 Void?，而不是 Void，因为通过可选链式调用得到的返回值都是可选的。这样我们就可以使用 if 语句来判断能否成功调用 printNumberOfRooms() 方法，即使方法本身没有定义返回值。通过判断返回值是否为 nil 可以判断调用是否成功
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }

        // 同样的，可以据此判断通过可选链式调用为属性赋值是否成功。在上面的 通过可选链式调用访问属性 的例子中，我们尝试给 john.residence 中的 address 属性赋值，即使 residence 为 nil。通过可选链式调用给属性赋值会返回 Void?，通过判断返回值是否为 nil 就可以知道赋值是否成功
        if (john.residence?.address = createAddress()) != nil {
            print("It was possible to set the address.")
        } else {
            print("It was not possible to set the address.")
        }
    }

    // MARK: - 通过可选链式调用访问下标
    private func accessingSubscripts() {
        let john = Person()
        john.residence = Residence()

        if let roomCount = john.residence?.numberOfRooms, roomCount > 0 {
            print("The first room name is \(john.residence?[0].name).")
        } else {
            print("Unable to retrieve the first room name.")

            john.residence?.rooms.append(Room(name: "Living Room"))
            john.residence?.rooms.append(Room(name: "Kitchen"))
            john.residence?[0] = Room(name: "Bathroom")

            if let firstRoomName = john.residence?[0].name {
                print("The first room name is \(firstRoomName).")
            } else {
                print("Unable to retrieve the first room name.")
            }
        }


        // 访问可选类型的下标
        var testScores = [
            "Dave": [86, 82, 84],
            "Bev": [79, 94, 81]
        ]
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0] += 1
        testScores["Brian"]?[0] = 72
        print("testScores = \(testScores)")
    }

    // MARK: - 连接多层可选链式调用
    private func linkingMultipleLevels() {
        /*
         通过可选链式调用访问一个 Int 值，将会返回 Int?，无论使用了多少层可选链式调用。
         类似的，通过可选链式调用访问 Int? 值，依旧会返回 Int? 值，并不会返回 Int??。
         */
        let john = Person()
        if let johnsStreet = john.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }

        john.residence = Residence()
        john.residence?.address = createAddress()
        if let johnsStreet = john.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
    }

    // MARK: - 在方法的可选返回值上进行可选链式调用
    private func onMethodsWithOptionalReturnValues() {
        let john = Person()
        john.residence = Residence()
        john.residence?.address = createAddress()
        if let buildingIdentifier = john.residence?.address?.buildingIdentifier()  {
            print("John's building identifier is \(buildingIdentifier).")
        }

        // 注意：在方法的圆括号后面加上问号是因为你要在 buildingIdentifier() 方法的可选返回值上进行可选链式调用，而不是 buildingIdentifier() 方法本身
        if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
            if beginsWithThe {
                print("John's building identifier begins with \"The\".")
            } else {
                print("John's building identifier does not begin with \"The\".")
            }
        }
    }
}