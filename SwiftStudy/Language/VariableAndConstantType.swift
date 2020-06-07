//
//  VariableAndConstantType.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2020/6/7.
//  Copyright © 2020 KenmuHuang. All rights reserved.
//

import UIKit

class VariableAndConstantType: NSObject {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

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
}
