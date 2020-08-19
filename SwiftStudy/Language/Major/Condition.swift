//
//  Condition.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2020/6/7.
//  Copyright © 2020 KenmuHuang. All rights reserved.
//

import UIKit

class Condition: NSObject {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

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
}
