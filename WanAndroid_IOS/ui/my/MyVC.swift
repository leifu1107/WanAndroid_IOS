//
//  MyVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/6/3.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import LGButton

class MyVC: UIViewController {
    
    var navHeight = CGFloat(60)
    
    private lazy var  divLine = UIView().then({
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    })
    
    func createLayout(index:Int,imageName:String,_ text:String) -> UIView {
        
        let uiView =  UIView().then({
            $0.backgroundColor = UIColor.white
        })
        let imageView =  UIImageView().then({
            $0.image = UIImage(named: imageName)
        })
        let label =  UILabel(text: text)
        
        uiView.addSubview(label)
        label.snp.makeConstraints{
            //            $0.right.equalTo(uiView.snp.right)
            //            $0.center.equalTo(uiView.snp.center)
            $0.right.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
        
        uiView.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.width.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(10)
            
        }
        //添加分割线
        //        uiView.addSubview(divLine)
        //        divLine.snp.makeConstraints{
        //            $0.left.equalToSuperview().offset(10)
        //            $0.right.equalToSuperview().offset(-10)
        //            $0.bottom.equalToSuperview()
        //            $0.height.equalTo(10)
        //        }
        //把UIview添加到view
        self.view.addSubview(uiView)
        uiView.snp.makeConstraints{
            //$0.edges.equalToSuperview().inset(UIEdgeInsets(top: CGFloat(100*index), left: 10, bottom: 10, right: 10))
            $0.height.equalTo(70)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            //设置导航下面显示，间隔20,150是登录高度
            $0.top.equalToSuperview().offset(CGFloat(80*index)+navHeight+20+150)
            
            
        }
        //设置圆角和边框
        uiView.layer.cornerRadius = 5
        uiView.layer.borderColor = UIColor.lightGray.cgColor
        uiView.layer.borderWidth = 1
        //设置阴影
        uiView.layer.shadowColor = UIColor.gray.cgColor
        uiView.layer.shadowOpacity = 0.5
        uiView.layer.shadowRadius = 0.8
        uiView.layer.shadowOffset = CGSize(width: 1, height: 1)
        return uiView
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false//隐藏导航栏 发现在viewDidLoad里面无效
        // 设置 title
        self.parent?.navigationItem.title = "我的";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navHeight = (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        self.view.backgroundColor = UIColor.background
        
//        //测试UIbutton和图片位置
//        let uiImage = UIImage(named: "cellphoneicon_login_profile_night_66x66_")
//        let newImg =  uiImage?.reSizeImage(reSize: CGSize(width: 60, height: 60))
//        let btn =  UIButton().then{
//            $0.set(image: newImg, title: "请登录", titlePosition: .Top, additionalSpacing: 20, state: .normal)
//            $0.setTitleColor(UIColor.black, for: .normal)
//            $0.frame = CGRect(x: 0, y: 100, width: 150, height: 150)
//        }
       
        
        let lgButton =  LGButton()
        lgButton.rightImageSrc =  UIImage(named: "cellphoneicon_login_profile_night_66x66_")
        lgButton.titleString = "登录"
        lgButton.frame = CGRect(x: 0, y: 100, width: 150, height: 150)
         self.view.addSubview(lgButton)
        
        createLayout(index: 0, imageName: "yaofan","测试0")
        createLayout(index: 1, imageName: "yaofan","测试1")
        createLayout(index: 2, imageName: "pic2.jpeg","测试2")
        let uiView3 = createLayout(index: 3, imageName: "pic2.jpeg","测试3")
        
        
    }
}
