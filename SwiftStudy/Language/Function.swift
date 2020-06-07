//
//  Function.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2020/6/7.
//  Copyright © 2020 KenmuHuang. All rights reserved.
//

import UIKit

class Function: NSObject {
    func main() -> Void {
        print(greet(person: "Bob", day: "Tuesday"))
        print(greet("John", on: "Wednesday"))
    }

    func greet(person: String, day: String) -> String {
        return "Hello \(person), today is \(day)."
    }

    func greet(_ person: String, on day: String) -> String {
        return greet(person: person, day: day)
    }
}
