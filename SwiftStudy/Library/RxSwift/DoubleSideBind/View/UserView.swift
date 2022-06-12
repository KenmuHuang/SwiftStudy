//
//  UserView.swift
//  SwiftStudy
//
//  Created by KenmuHuang on 2022/6/12.
//  Copyright © 2022 KenmuHuang. All rights reserved.
//

import UIKit

class UserView: UIView {
    /// 输入文本标签
    @IBOutlet weak var lblInput: UILabel!
    /// 输入文本框
    @IBOutlet weak var txtFInput: UITextField!

    private lazy var userVM: UserViewModel = {
        let userVM = UserViewModel()
        return userVM
    }()
    typealias CommonBlock = (String?) -> Void
    var sureBlock: CommonBlock?

    override func awakeFromNib() {
        super.awakeFromNib()

        createSubviews()
        bind()
        addNotificationObserver()
    }

    deinit {
        funcLogDebug("\(NSStringFromClass(type(of: self))) deinit")
    }

    func update() {

    }

    // MARK: - Private Method
    private func createSubviews() {
        // 创建视图
        txtFInput.becomeFirstResponder()

        // 约束
    }

    private func bind() {
        // 将「用户名」数据与「输入文本框」进行双向绑定
//        userVM.username.asObservable()
//                .bind(to: txtFInput.rx.text)
//                .disposed(by: rx.disposeBag)
//
//        txtFInput.rx.text.orEmpty
//                .bind(to: userVM.username)
//                .disposed(by: rx.disposeBag)
        (txtFInput.rx.textInput <-> userVM.username)
                .disposed(by: rx.disposeBag)

        // 将「用户信息」数据绑定到「输入文本标签」
        userVM.userInfo
                .bind(to: lblInput.rx.text)
                .disposed(by: rx.disposeBag)
    }

    // MARK: - Event
    @IBAction func btnSureClicked(_ sender: Any) {
        sureBlock?(lblInput.text)
    }

    // MARK: - NSNotificationCenter
    private func addNotificationObserver() {

    }
}
