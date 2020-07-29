//
//  LoginVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/7/16.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    lazy var  desLabel = UILabel().then({
        //           $0.frame = CGRect(x: 20, y: 100, width: screenWidth, height: 50)
        $0.text = "欢迎回家"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 30)
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
    })
    
    lazy var phoneLeftView = UIView().then({
        $0.frame = CGRect(x: 0, y: 0, width: 20, height: 1)
    })
    lazy var pwdLeftView = UIView().then({
        $0.frame = CGRect(x: 0, y: 0, width: 20, height: 1)
    })
    
    lazy var phoneTextField = UITextField().then({
        //        $0.frame = CGRect(x: 0, y: 0, width: screenWidth-40, height: 40)
        $0.leftViewMode = .always
        $0.leftView = self.phoneLeftView
        $0.placeholder = "请输入手机号"
        $0.tintColor = UIColor.red
        $0.textAlignment = .left
        $0.clearButtonMode = .whileEditing
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        $0.keyboardType = .numberPad
        $0.backgroundColor = UIColor(white: 0.8, alpha: 0.4)
    })
    
    lazy var pwdTextField = UITextField().then({
        //        $0.frame = CGRect(x: 0, y: 60, width: screenWidth-40, height: 40)
        $0.leftViewMode = .always
        //需要重新创建一个
        $0.leftView = self.pwdLeftView
        $0.placeholder = "请输入验证码"
        $0.textAlignment = .left
        $0.clearButtonMode = .whileEditing
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(white: 0.8, alpha: 0.4)
    })
    
    lazy var  btnMsg = UIButton().then({
        //        $0.frame = CGRect(x: self.pwdTextField.bounds.width-65, y: 65, width: 60, height: 30)
        $0.setTitle("获取验证码", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.addTarget(self, action:#selector(btnMsgClick), for: .touchUpInside)
        //        $0.layer.cornerRadius = 5
        //        $0.layer.masksToBounds = true
        //        $0.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    })
    
    lazy var gradientLayer = CAGradientLayer().then({
        $0.frame = self.btnLogin.bounds
        //设置渐变的主颜色
        $0.colors = [UIColor.purple.cgColor, UIColor.brown.cgColor]
    })
    
    lazy var btnLogin = UIButton().then({
        $0.frame = CGRect(x: 70, y: 380, width: screenWidth-140, height: 40)
        $0.setTitle("登录", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.orange, for: .selected)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        //        $0.backgroundColor = UIColor.red
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //描述文字
        self.view.addSubview(desLabel)
        desLabel.snp.makeConstraints{
            $0.left.equalTo(20)
            $0.top.equalTo(100)
        }
        //手机输入
        self.view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints({
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.top.equalTo(200)
            $0.height.equalTo(40)
        })
        //输入n密码
        self.view.addSubview(pwdTextField)
        pwdTextField.snp.makeConstraints({
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.top.equalTo(260)
            $0.height.equalTo(40)
        })
        //发送验证码
        self.view.addSubview(btnMsg)
        btnMsg.snp.makeConstraints({
            $0.right.equalTo(pwdTextField.snp.right)
            $0.top.equalTo(260)
            $0.height.equalTo(40)
            $0.width.equalTo(100)
        })
        //添加登录(使用snp渐变色显示不出来)
        self.view.addSubview(btnLogin)
        //        btnLogin.snp.makeConstraints{
        ////            $0.left.equalTo(20)
        ////            $0.right.equalTo(-20)
        //            $0.top.equalTo(380)
        //            $0.height.equalTo(40)
        //            $0.width.equalTo(200)
        //            $0.centerX.equalToSuperview()
        //        }
        
        btnLogin.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    private var secondsCount = 10
    private var timer:Timer?
    
    @objc func btnMsgClick()  {
        print("点击了确定验证码")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFire), userInfo: nil, repeats: true)
    }
    @objc func timeFire()  {
        print(self.secondsCount)
        if self.secondsCount <= 0 {
            self.timer?.invalidate()
            self.timer = nil
            self.btnMsg.isEnabled = true
            self.btnMsg.setTitle("获取验证码", for: .normal)
            self.secondsCount = 10
        } else {
            self.btnMsg.isEnabled = false
            let title = "\(self.secondsCount)秒后重新获取"
            self.btnMsg.setTitle(title, for: .normal)
        }
        self.btnMsg.sizeToFit()
        self.secondsCount -= 1
    }
    
    /**
     隐藏键盘
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

