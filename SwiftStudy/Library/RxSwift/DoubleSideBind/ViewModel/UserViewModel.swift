//
//  UserViewModel.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2022/6/12.
//  Copyright © 2022 KenmuHuang. All rights reserved.
//

import UIKit

struct UserViewModel {
    /// 用户名
    let username = BehaviorRelay(value: "guest")

    /// 用户信息
    lazy var userInfo = {
        username.asObservable()
                .map {
                    $0 == "admin" ? "管理员" : "访客"
                }
                .share(replay: 1)
    }()

}
