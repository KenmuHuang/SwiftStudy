//
//  ViewController.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2020/5/28.
//  Copyright © 2020 KenmuHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     /// 封面图片视图
    @IBOutlet weak var imgVAvatar: UIImageView!
    
    /// 获取随机图片按钮
    @IBOutlet weak var btnRandomImage: UIButton!
    
    /// 随机图片数组
    let arrImageName = ["icon_home_dynamic_yellow", "icon_home_dynamic_blue", "icon_home_top_book_club"];
    
    /// 随机图片索引下标数
    var randomImageNameIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateImage()
        testVariableAndConstantType()
        testCondition()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateImage()
    }
    
    func updateImage() -> Void {
        randomImageNameIndex = Int(arc4random_uniform(3))
        print("randomImageNameIndex = \(randomImageNameIndex)")
        
        if randomImageNameIndex < arrImageName.count {
            imgVAvatar.image = UIImage(named: arrImageName[randomImageNameIndex])
        }
    }

    func testVariableAndConstantType() -> Void {
        print("Hello, world!")

        var myVariable = 42
        myVariable = 50

        let myConstant = 42

        let implicitInteger = 70
        let implicitDouble = 70.0

        let label = "The width is "
        let width = 94
        let widthLabel = label + String(width)

        let apples = 3
        let oranges = 5
        let appleSummary = "I have \(apples) apples."
        let fruitSummary = "I have \(apples + oranges) pieces of fruits."
        let quotation = """
                        I said "I have \(apples) apples."
                        And then I said "I have \(apples + oranges) pieces of fruits."
                        """

        var shoppingList = ["catfish", "water", "tulips"]
        shoppingList[1] = "bottle of water"
        shoppingList.append("blue paint")
        print(shoppingList)

        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
        ]
        occupations["Jayne"] = "Public Relations"

        let emptyArray = [String]()
        let emptyDictionary = [String: Float]()
    }

    func testCondition() -> Void {
        // For
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
        }
        print(teamScore)

        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        var largestNumbers = [String: Int]()
        var largest = 0
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
            largestNumbers[kind] = largest
            largest = 0
        }
        print(largestNumbers.sorted(by: >)) // descending

        // If
        var optionalString: String? = "Hello"
        optionalString = nil
        print(optionalString == nil)

        var optionalName: String? = "John Appleseed"
        optionalName = nil
        var greeting: String = "Hello!"
//        greeting = nil // error
        if let name = optionalName {
            greeting = "Hello, \(name)"
        } else {
            let defaultName = "Lisa"
            greeting = "Hello, \(optionalName ?? defaultName)"
        }

        // Switch
        let vegetable = "red pepper"
        switch vegetable {
        case "celery": 
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):
            print("Is it a spicy \(x)?")
        default:
            print("Everything tastes good in soup.")
        }

        // While
        var n = 2
        while n < 100 {
            n *= 2
        }
        print(n)

        var m = 2
        repeat {
            m *= 2
        } while m < 100
        print(m)

        var total = 0
        for i in 0..<4 {
            // exclude 4
            total += i
        }
        print(total)

        total = 0
        for i in 0...4 {
            // include 4
            total += i
        }
        print(total)
    }
    
    @IBAction func onRandomImageButtonClicked(_ sender: Any) {
        updateImage()
    }
}

