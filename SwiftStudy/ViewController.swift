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
    
    @IBAction func onRandomImageButtonClicked(_ sender: Any) {
        updateImage()

        // 学习的内容暂时放这测试，测试完成再放到 viewDidLoad
        Functions().main()
    }
}

