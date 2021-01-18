//
//  NSLayoutConstraint+Extension.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2021/1/19.
//  Copyright © 2021 KenmuHuang. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    ///
    /// 根据宽高比例，返回新的约束
    /// - Parameter multiplier: 宽高比例
    /// - Returns: 新的约束
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(item: firstItem!, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
