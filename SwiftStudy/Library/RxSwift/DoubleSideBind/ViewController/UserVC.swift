//
//  UserVC.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2022/6/12.
//  Copyright © 2022 KenmuHuang. All rights reserved.
//

import UIKit

/// 用户页面
class UserVC: UIViewController {
    private lazy var userView: UserView = {
        let view: UserView = UserView.fromNib()
        view.sureBlock = { [weak self] in
            guard let result = $0 else {
                return
            }
            self?.title = result
//            self?.navigationController?.navigationItem.title = result
        }
        return view
    }()

    deinit {
        funcLogDebug("\(NSStringFromClass(type(of: self))) deinit")
    }

    // MARK: - Load
    private func layoutUI() {
        view.backgroundColor = .white

        createSubviews()
    }

    private func createSubviews() {
        view.addSubview(userView)
    }

    // MARK: - Private Method

    // MARK: - NSNotificationCenter
    private func addNotificationObserver() {

    }
}

// MARK: - Life Cycle
extension UserVC {
    open override func viewDidLoad() {
        super.viewDidLoad()

        layoutUI()
        addNotificationObserver()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
