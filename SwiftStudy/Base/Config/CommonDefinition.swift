//
//  CommonDefinition.swift
//  Common
//
//  Created by KenmuHuang on 2021/3/26.
//  Copyright © 2021 HaRi. All rights reserved.
//

import UIKit
import SnapKit
import SwifterSwift

// MARK: - 全局引用

@_exported import RxSwift
@_exported import RxCocoa
@_exported import RxGesture
@_exported import NSObject_Rx

// MARK: - 通用值
let kMinHeightOfHiddenGroupTableHeader: CGFloat = 0.01
let kMinHeightOfHiddenPlainTableHeader: CGFloat = 0.0
let kHalfTopPadding: CGFloat = 7.5
let kShadowAlpha: CGFloat = 0.05
let kShadowColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.05)
let kShareFrame: CGRect = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
let kHighlightedColorName: String = "highlightedColor"

// MARK: - Block
typealias BaseBlock = () -> Void


// MARK: - 简化写法
let kApplication = UIApplication.shared
let kScreen = UIScreen.main
let kRunLoop = RunLoop.main
let kBundle = Bundle.main
let kFileManager = FileManager.default
let kUserDefaults = UserDefaults.standard
let kNotificationCenter = NotificationCenter.default
let kLocaleLanguage = Locale.preferredLanguages.first
let kDevice = UIDevice.current


// MARK: - iOS 版本
public func funcIsGreaterThanOrEqualToOSVersion(_ version: String) -> Bool {
    kOSVersion.compare(version, options: .numeric) != .orderedAscending
}

public func funcIsLessThanOSVersion(_ version: String) -> Bool {
    kOSVersion.compare(version, options: .numeric) == .orderedAscending
}

let kOSVersion = kDevice.systemVersion
let kIsOS10OrLater = funcIsGreaterThanOrEqualToOSVersion("10.0")
let kIsOS10Dot2OrLater = funcIsGreaterThanOrEqualToOSVersion("10.2")
let kIsOS10Dot3OrLater = funcIsGreaterThanOrEqualToOSVersion("10.3")
let kIsOS11OrBefore = funcIsLessThanOSVersion("12.0")
let kIsOS11OrLater = funcIsGreaterThanOrEqualToOSVersion("11.0")
let kIsOS12OrLater = funcIsGreaterThanOrEqualToOSVersion("12.0")
let kIsOS13OrBefore = funcIsLessThanOSVersion("14.0")
let kIsOS13OrLater = funcIsGreaterThanOrEqualToOSVersion("13.0")
let kIsOS14OrLater = funcIsGreaterThanOrEqualToOSVersion("14.0")
let kIsOS15OrLater = funcIsGreaterThanOrEqualToOSVersion("15.0")


// MARK: - App（包的唯一标示、显示名称、Version 版本）
let kAppBundleIdentifier = kBundle.bundleIdentifier
let kAppDisplayName = kBundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
let kAppVersion = kBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""


// MARK: - 判断机型
public func funcCheckDevice(_ deviceName: String) -> Bool {
    kDevice.model == deviceName
}

public func funcIsMatchingSize(_ size: CGSize) -> Bool {
    if UIScreen.instancesRespond(to: #selector(getter: kScreen.currentMode)) {
        return (kScreen.currentMode?.size ?? CGSize.zero).equalTo(size)
    }
    return false
}

// 是否是 iPhone、iPad、模拟器
let kIsPhone = funcCheckDevice("iPhone") || funcCheckDevice("iPhone Simulator")
let kIsPad = funcCheckDevice("iPad") || funcCheckDevice("iPad Simulator")
let kIsSimulator = TARGET_OS_SIMULATOR == 1

// 判断机型；根据屏幕分辨率区别「像素」=屏幕大小「点素」*屏幕模式「iPhone 4开始比例就为2x」;iPhone 6 跟 7、8 一样；iPhone 6 Plus 跟 7 Plus、8 Plus 一样
// @2x 机型：4（320 x 480 pt，3.5 英寸）、5（320 x 568 pt，4 英寸）、6（375 x 667 pt，4.7 英寸）、XR（414 x 896 pt，6.1 英寸）
// @3x 机型：6Plus（414 x 736 pt，5.5 英寸）、X 和 XS（375 x 812 pt，5.8 英寸，实际手握大小跟 6 差不多）、XSMax（414 x 896 pt，6.5 英寸，实际手握大小跟 Plus 差不多）、12 Mini（360 x 780 pt，5.4 英寸，实际手握大小跟 SE 差不多）、12 和 12 Pro（390 x 844 pt，6.1 英寸，实际手握大小介于 6 跟 Plus 之间）、12 Pro Max（428 x 926 pt，6.7 英寸，实际手握大小 Plus 差不多）
let kIsPhone4 = funcIsMatchingSize(CGSize(width: 640.0, height: 960.0))
let kIsPhone5 = funcIsMatchingSize(CGSize(width: 640.0, height: 1136.0))
let kIsPhone6 = funcIsMatchingSize(CGSize(width: 750.0, height: 1334.0))
let kIsPhone6Plus = funcIsMatchingSize(CGSize(width: 1242.0, height: 2208.0))
let kIsPhoneXOrXS = funcIsMatchingSize(CGSize(width: 1125.0, height: 2436.0))
let kIsPhoneXR = funcIsMatchingSize(CGSize(width: 828.0, height: 1792.0))
let kIsPhoneXSMax = funcIsMatchingSize(CGSize(width: 1242.0, height: 2688.0))
let kIsPhone12Mini = funcIsMatchingSize(CGSize(width: 1080.0, height: 2340.0))
let kIsPhone12 = funcIsMatchingSize(CGSize(width: 1170.0, height: 2532.0))
let kIsPhone12Pro = kIsPhone12
let kIsPhone12ProMax = funcIsMatchingSize(CGSize(width: 1284.0, height: 2778.0))
let kIsPhoneOldModel = kIsPhone6Plus || kIsPhone6 || kIsPhone5 || kIsPhone4
let kIsSmallSizePhone = kIsPhone5 || kIsPhone4
let kIsSmallSize = kIsPhone5 || kIsPhone4 || kIsPad

/// 判断是否是刘海屏
var kIsPhoneXModel: Bool {
    if #available(iOS 11.0, *), UI_USER_INTERFACE_IDIOM() == .phone {
        let size = UIScreen.main.bounds.size
        let notchValue: Int = Int(size.width / size.height * 100)
        return notchValue == 216 || notchValue == 46
    }
    return false
}

// MARK: - 屏幕大小、常用控件高度（状态栏、导航栏、选项卡、HomeBar）
public func funcIsUseSafeArea() -> Bool {
    if kIsOS12OrLater {
        return true
    } else if kIsOS11OrLater {
        return kIsPhone && !kIsPhoneOldModel
    }
    return false
}

public func funcSafeAreaInsets() -> UIEdgeInsets {
    if #available(iOS 11.0, *) {
        return kApplication.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
    }
    return UIEdgeInsets.zero
}

// 屏幕大小
let kFrameOfMainScreen = kScreen.bounds
let kWidthOfMainScreen = kFrameOfMainScreen.size.width
let kHeightOfMainScreen = kFrameOfMainScreen.size.height
let kHeightOfStatus: CGFloat = funcIsUseSafeArea() ? funcSafeAreaInsets().top : 20.0
let kHeightOfNavigation: CGFloat = 44.0
let kHeightOfStatusAndNavigation = kHeightOfStatus + kHeightOfNavigation
let kHeightOfHomeBar: CGFloat = funcIsUseSafeArea() ? funcSafeAreaInsets().bottom : 0.0
let kHeightOfTabContent: CGFloat = 49.0
let kHeightOfTabBar = kHeightOfHomeBar + kHeightOfTabContent
let kAbsoluteHeightOfMainScreen = kHeightOfMainScreen - kHeightOfStatusAndNavigation


// MARK: - 宽高比例
public func funcScaleWidth(_ width: CGFloat) -> CGFloat {
    width * (kWidthOfMainScreen / (kIsPad ? 768.0 : 375.0))
}

public func funcScaleHeight(_ height: CGFloat) -> CGFloat {
    height * (kHeightOfMainScreen / (kIsPad ? 1024.0 : (kIsPhoneXModel ? 812.0 : 667.0)))
}

let kWidthFactorOfPhone5 = kWidthOfMainScreen / 320.0
let kWidthFactorOfPhone6 = kWidthOfMainScreen / 375.0
let kHeightFactorOfPhone5 = kHeightOfMainScreen / 568.0
let kHeightFactorOfPhone6 = kHeightOfMainScreen / 667.0


// MARK: - 文件读取
public func funcFilePath(fileName: String, type: String) -> String? {
    kBundle.path(forResource: fileName, ofType: type)
}

public func funcImage(fileName: String, type: String) -> UIImage? {
    if let filePath = funcFilePath(fileName: fileName, type: type) {
        return UIImage(contentsOfFile: filePath)
    }
    return nil
}

// 沙盒目录
let kHomePath = NSHomeDirectory()
let kTempPath = NSTemporaryDirectory()
let kDocumentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
let kLibraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
let kCachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!


// MARK: - 数据类型转换
public func funcGetSafeArrayFromDic(dic: [String: Any], key: String) -> [Any] {
    if let obj = dic[key], obj is [Any] {
        return (obj as! [Any])
    }
    return []
}

public func funcGetSafeDicFromDic(dic: [String: Any], key: String) -> [String: Any] {
    if let obj = dic[key], obj is [String: Any] {
        return (obj as! [String: Any])
    }
    return [:]
}

public func funcGetSafeStringFromDic(dic: [String: Any], key: String) -> String {
    if let obj = dic[key], obj is String {
        return (obj as! String)
    }
    return ""
}

public func funcGetSafeIntFromDic(dic: [String: Any], key: String) -> Int {
    funcGetSafeInt(originValue: dic[key])
}

public func funcGetSafeInt(originValue: Any?) -> Int {
    if let obj = originValue {
        if obj is Int {
            return (obj as! Int)
        }
        if obj is String {
            return Int(obj as! String) ?? 0
        }
        if obj is Double {
            return Int(obj as! Double)
        }
        if obj is Float {
            return Int(obj as! Float)
        }
        if obj is CGFloat {
            return Int(obj as! CGFloat)
        }
    }
    return 0
}

public func funcGetSafeDoubleFromDic(dic: [String: Any], key: String) -> Double {
    if let obj = dic[key] {
        if obj is Double {
            return (obj as! Double)
        }
        if obj is String {
            return Double(obj as! String) ?? 0.0
        }
        if obj is Int {
            return Double(obj as! Int)
        }
        if obj is Float {
            return Double(obj as! Float)
        }
        if obj is CGFloat {
            return Double(obj as! CGFloat)
        }
    }
    return 0.0
}

public func funcGetSafeBoolFromDic(dic: [String: Any], key: String) -> Bool {
    if let obj = dic[key] {
        if obj is Bool {
            return (obj as! Bool)
        }
        if obj is String {
            let objStr = obj as! String
            return objStr == "1" || (Bool(objStr) ?? false)
        }
        if obj is Int {
            return obj as! Int == 1
        }
        if obj is Double {
            return obj as! Double == 1.0
        }
        if obj is Float {
            return obj as! Float == 1.0
        }
        if obj is CGFloat {
            return obj as! CGFloat == 1.0
        }
    }
    return false
}


// MARK: - 日志
private func funcLog(_ text: String, _ typeSign: String, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
    guard text.count > 0 else {
        return
    }
    let arrFileStringPart = file.components(separatedBy: "/")
    guard arrFileStringPart.count > 0 else {
        return
    }
    let content = "\(arrFileStringPart.last!) \(function) 第 \(line) 行\n [\(typeSign)]\(text)\n\n"

    switch typeSign {
    case "Verbose":
        print(content)
    case "Debug":
        print(content)
    case "Info":
        print(content)
    case "Warn":
        print(content)
    case "Error":
        print(content)
    default:
        break
    }
}

public func funcLogVerbose(_ text: String, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
    funcLog(text, "Verbose", file, line, function)
}

public func funcLogDebug(_ text: String, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
    funcLog(text, "Debug", file, line, function)
}

public func funcLogInfo(_ text: String, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
    funcLog(text, "Info", file, line, function)
}

public func funcLogWarn(_ text: String, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
    funcLog(text, "Warn", file, line, function)
}

public func funcLogError(_ text: String, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
    funcLog(text, "Error", file, line, function)
}


// MARK: - 字体
public func funcBebasKaiFont(_ size: CGFloat) -> UIFont {
    UIFont(name: "BebasKai", size: size) ?? UIFont.systemFont(ofSize: size)
}
