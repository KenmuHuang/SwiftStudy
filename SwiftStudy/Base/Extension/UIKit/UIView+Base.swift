//
//  UIView+Base.swift
//  xinli001
//
//  Created by KenmuHuang on 2020/5/26.
//  Copyright © 2020 xinli001. All rights reserved.
//

import UIKit

public extension UIView {
    // MARK: - NIB
    static func fromNib<T: UIView>() -> T {
        let objects = Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)
        let object = objects?.single(where: { object in
            // 避免拿到的是手势对象
            object is T
        })
        guard let view = object as? T else {
            funcLogDebug("\(String(describing: T.self)) invalid view.")
            return T()
        }
        return view
    }

    // MARK: - Effect
    func blurEffect(style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds

        // 适配设备旋转
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(blurEffectView)
        sendSubviewToBack(blurEffectView)
        backgroundColor = .clear
        clipsToBounds = true
    }
}
