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

    /// 输入内容文本框
    @IBOutlet weak var txtFInputContent: UITextField!
    
    /// 输入内容对应转换按钮
    @IBOutlet weak var btnConvert: UIButton!
    
    /// 随机图片数组
    let arrImageName = ["icon_home_dynamic_yellow", "icon_home_dynamic_blue", "icon_home_top_book_club"];
    
    /// 随机图片索引下标数
    var randomImageNameIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateImage()
//        VariableAndConstantType().main()
//        Condition().main()
//        Function().main()
//        Class().main()
//        EnumerationAndStructure().main()
//        ProtocolAndExtension().main()
//        ErrorHandle().main()
//        Generic().main()
        TheBasics().main()
        BasicOperators().main()
        StringsAndCharacters().main()
        CollectionTypes().main()
        ControlFlow().main()
        Functions().main()
        Closures().main()
        Enumerations().main()
        StructuresAndClasses().main()
        Properties().main()
        Methods().main()
        Subscripts().main()
        Inheritance().main()
        Initialization().main()
        Deinitialization().main()
        OptionalChaining().main()
        ErrorHandling().main()
        TypeCasting().main()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateImage()
    }
    
    @IBAction func onRandomImageButtonClicked(_ sender: Any) {
        updateImage()

        // 学习的内容暂时放这测试，测试完成再放到 viewDidLoad
        NestedTypes().main()
    }
    
    @IBAction func onConvertButtonClicked(_ sender: Any) {
        let content = txtFInputContent.text
        if content != nil {
            // 包含-或_的内容，转换为驼峰式
            var separator: Character = "-"
            if content!.contains(separator) {
                txtFInputContent.text = getConvertedContent(content: content!, separator: separator)
                return
            }

            separator = "_"
            if content!.contains(separator) {
                txtFInputContent.text = getConvertedContent(content: content!, separator: separator)
            }
        }
    }

    // MARK: - Private Method
    private func updateImage() -> Void {
        randomImageNameIndex = Int(arc4random_uniform(3))
        print("randomImageNameIndex = \(randomImageNameIndex)")

        if randomImageNameIndex < arrImageName.count {
            imgVAvatar.image = UIImage(named: arrImageName[randomImageNameIndex])
        }
    }

    private func getConvertedContent(content: String, separator: Character) -> String {
        guard content.count > 0 else {
            return "";
        }

        var contentList = content.split(separator: separator)
        let count = contentList.count
        guard count > 1 else {
            return content
        }

        // 方式一
//        var convertedContent: String = String(contentList[0])
//        for index in 1..<count {
//            convertedContent += uppercaseFirstChar(String(contentList[index]))
//        }
//        return convertedContent

        // 方式二
//        var result = [String]();
//        for (index, value) in contentList.enumerated() {
//            if index > 0 {
//                result.append(uppercaseFirstChar(String(value)))
//            } else {
//                result.append("\(value)")
//            }
//        }
//        return result.joined();

        // 方式三
        var result = [String(contentList[0])];
        contentList.removeFirst()
        for (_, value) in contentList.enumerated() {
            result.append(uppercaseFirstChar(String(value)))
        }
        return result.joined();
    }

    private func uppercaseFirstChar(_ content: String) -> String {
        guard content.count > 0 else {
            return content
        }

        let range = content.startIndex..<content.index(content.startIndex, offsetBy: 1)
        let firstLowerChar = content[range].uppercased()
        return content.replacingCharacters(in: range, with: firstLowerChar)
    }
}

