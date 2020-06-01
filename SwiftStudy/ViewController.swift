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
    
    @IBAction func onRandomImageButtonClicked(_ sender: Any) {
        updateImage()
    }
}

