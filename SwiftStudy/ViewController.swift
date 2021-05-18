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
    /// 封面图片视图 - 宽高比例
    @IBOutlet weak var aspectOfAvatarImageView: NSLayoutConstraint!
    /// 透明度动画视图
    @IBOutlet weak var opacityAnimationView: UIView!
    /// 缩放动画视图
    @IBOutlet weak var scaleAnimationView: UIView!
    /// 透明度和缩放动画视图
    @IBOutlet weak var opacityScaleAnimationView: UIView!

    /// 随机图片数组
    let arrImageName = ["icon_home_dynamic_yellow", "icon_home_dynamic_blue", "home_ambush_bg", "icon_dynamic_hot_recommend"];
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
        NestedTypes().main()
        Extensions().main()
        Protocols().main()
        Generics().main()
        OpaqueTypes().main()
        AutomaticReferenceCounting().main()
        MemorySafety().main()
        AccessControl().main()
        AdvancedOperators().main()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateImage()
    }

    // MARK: - Event
    @IBAction func onRandomImageButtonClicked(_ sender: Any) {
        updateImage()

        // 学习的内容暂时放这测试，算法测试
        Bubble().main()
        Select().main()
    }
    
    @IBAction func onConvertButtonClicked(_ sender: Any) {
        let content = txtFInputContent.text
        if content != nil {
            // 包含-或_的内容，转换为驼峰式
            let separatorList: [Character] = ["-", "_"]
            for separator in separatorList {
                if content!.contains(separator) {
                    txtFInputContent.text = getConvertedContent(content: content!, separator: separator)

                    // 复制转换的内容到粘贴板
                    UIPasteboard.general.string = txtFInputContent.text
                    break
                }
            }
        }
    }

    @IBAction func onShowAnimationButtonClicked(_ sender: Any) {
        opacityAnimation()
        scaleAnimation()
        opacityScaleAnimation()

//        guard let sender = sender as? UIButton else { return }
//        sender.isEnabled = false
    }

    // MARK: - Private Method
    private func updateImage() -> Void {
        let imageCount = arrImageName.count
        randomImageNameIndex = Int(arc4random_uniform(UInt32(imageCount)))
        print("randomImageNameIndex = \(randomImageNameIndex)")

        if randomImageNameIndex < imageCount {
            if let image = UIImage(named: arrImageName[randomImageNameIndex]) {
                imgVAvatar.image = image
                aspectOfAvatarImageView = aspectOfAvatarImageView.setMultiplier(multiplier: image.size.width / image.size.height)
            }
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

    private func opacityAnimation() {
        if let sublayers = opacityAnimationView.layer.sublayers {
            for layer in sublayers {
                if layer is CAReplicatorLayer {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }

        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        replicatorLayer.borderColor = UIColor.white.cgColor
        replicatorLayer.cornerRadius = 5.0
        replicatorLayer.borderWidth = 1.0

        let circle = CALayer()
        circle.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 10, height: 10))
        circle.backgroundColor = UIColor.white.cgColor
        circle.cornerRadius = circle.frame.size.width / 2
        circle.position = CGPoint(x: 20, y: 40)
        replicatorLayer.addSublayer(circle)

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.duration = 1.0
        opacityAnimation.repeatCount = Float.greatestFiniteMagnitude
        circle.add(opacityAnimation, forKey: nil)

        let instanceCount = 10
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceDelay = opacityAnimation.duration / CFTimeInterval(instanceCount)

        let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        opacityAnimationView.layer.addSublayer(replicatorLayer)
    }

    private func scaleAnimation() {
        if let sublayers = scaleAnimationView.layer.sublayers {
            for layer in sublayers {
                if layer is CAReplicatorLayer {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }

        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        replicatorLayer.borderColor = UIColor.white.cgColor
        replicatorLayer.cornerRadius = 5.0
        replicatorLayer.borderWidth = 1.0

        let circle = CALayer()
        circle.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 10, height: 10))
        circle.backgroundColor = UIColor.white.cgColor
        circle.cornerRadius = circle.frame.size.width / 2
        circle.position = CGPoint(x: 20, y: 40)
        replicatorLayer.addSublayer(circle)

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.4
        scaleAnimation.duration = 1.0
        scaleAnimation.repeatCount = Float.greatestFiniteMagnitude
        circle.add(scaleAnimation, forKey: nil)

        let instanceCount = 10
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceDelay = scaleAnimation.duration / CFTimeInterval(instanceCount)

        let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        scaleAnimationView.layer.addSublayer(replicatorLayer)
    }

    private func opacityScaleAnimation() {
        if let sublayers = opacityScaleAnimationView.layer.sublayers {
            for layer in sublayers {
                if layer is CAReplicatorLayer {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }

        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        replicatorLayer.borderColor = UIColor.white.cgColor
        replicatorLayer.cornerRadius = 5.0
        replicatorLayer.borderWidth = 1.0

        let circle = CALayer()
        circle.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 12, height: 4))
        circle.backgroundColor = UIColor.white.cgColor
        circle.cornerRadius = 2.0
        circle.position = CGPoint(x: 20, y: 40)
        replicatorLayer.addSublayer(circle)

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.duration = 1.0
        opacityAnimation.repeatCount = Float.greatestFiniteMagnitude
        circle.add(opacityAnimation, forKey: nil)

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.4
        scaleAnimation.duration = 1.0
        scaleAnimation.repeatCount = Float.greatestFiniteMagnitude
        circle.add(scaleAnimation, forKey: nil)

        let instanceCount = 10
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceDelay = scaleAnimation.duration / CFTimeInterval(instanceCount)

        let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        opacityScaleAnimationView.layer.addSublayer(replicatorLayer)
    }
}

