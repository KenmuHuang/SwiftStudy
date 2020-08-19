//
// Created by KenmuHuang on 2020/8/16.
// Copyright (c) 2020 KenmuHuang. All rights reserved.
//

import UIKit

let throwPrinterName1 = "Out Of Paper"
let throwPrinterName2 = "Never Has Toner"
let throwPrinterName3 = "On Fire"

var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

class ErrorHandling {
    func main() -> Void {
        print("\n===\(NSStringFromClass(type(of: self)))===")

        // 多个 catch 块处理特定的错误，先 catch 到先执行，后面的不执行
        // 打印：I'll just put this over here, with the rest of the fire.
        do {
            let printerResponse = try send(job: 1040, toPrinter: throwPrinterName3)
            print(printerResponse)
        } catch PrinterError.onFire {
            print("I'll just put this over here, with the rest of the fire.")
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
        } catch {
            print(error)
        }

        // try? 表示将结果转换为可选的。如果函数抛出错误，该错误会被抛弃并且结果为 nil。否则，结果会是一个包含函数返回值的可选值
        // 打印：printerSuccess = Optional("Job sent"), printerFailure = nil
        let printerSuccess = try? send(job: 1884, toPrinter: "Has Toner")
        let printerFailure = try? send(job: 1885, toPrinter: throwPrinterName1)
        print("printerSuccess = \(printerSuccess ?? ""), printerFailure = \(printerFailure ?? "")")

        // defer 代码块来表示在函数返回前，函数中最后执行的代码。无论函数是否会抛出错误，这段代码都将执行
        let fruit = "banana"
        let isFridgeContain = fridgeContains(fruit)
        print("Is fridge contain \(fruit)? \(isFridgeContain ? "YES" : "NO")")
    }
}

enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == throwPrinterName1 {
        throw PrinterError.outOfPaper
    } else if printerName == throwPrinterName2 {
        throw PrinterError.noToner
    } else if printerName == throwPrinterName3 {
        throw PrinterError.onFire
    }
    return "Job sent"
}

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }

    return fridgeContent.contains(food)
}
