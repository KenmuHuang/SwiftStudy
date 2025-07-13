//
//  UIColor+Base.swift
//  xinli001
//
//  Created by KenmuHuang on 2021/4/25.
//  Copyright © 2021 xinli001. All rights reserved.
//

import UIKit

public extension UIColor {
    // MARK: - Hex
    static func fromHexString(_ hexString: String, alpha: CGFloat = 1) -> UIColor {
        guard let color = UIColor(hexString: hexString, transparency: alpha) else {
            funcLogDebug("Invalid hex string: \(hexString)")
            return UIColor.black
        }
        return color
    }
    
    class func rgb(red: Int, green: Int, blue: Int, alpha: CGFloat? = 1) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha ?? 1)
    }
}
