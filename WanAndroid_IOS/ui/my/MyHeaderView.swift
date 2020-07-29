//
//  MyHeaderView.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/7/14.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import Reusable

class MyHeaderView: UITableViewHeaderFooterView , Reusable{
    
    
    private lazy var  imageView = UIImageView().then({
        $0.image = UIImage(named: "pic3.jpeg")
    })
    
    lazy var nickImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pic2.jpeg")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 35
        //设置可以点击
        imageView.isUserInteractionEnabled = true
//        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(btnLoginClick)))
        return imageView
    }()
    
    lazy var loginLabel : UILabel = {
        let label = UILabel()
        label.text = "点击头像登录"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var subloginLabel : UILabel = {
        let label = UILabel()
        label.text = "登录后可以使用更多精彩功能呦"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    
    private lazy var tagView : TagView = {
        let view = TagView()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func setUpUI()  {
        //添加登录背景图
        self.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        //添加头像
        self.addSubview(nickImageView)
        nickImageView.snp.makeConstraints{
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
            $0.width.height.equalTo(70)
        }
        
        //添加登录
        self.addSubview(loginLabel)
        loginLabel.snp.makeConstraints{
            $0.left.equalTo(self.nickImageView.snp.right).offset(10)
            $0.top.equalToSuperview().offset(25)
            $0.height.equalTo(30)
        }
        
        //添加登录描述
        self.addSubview(subloginLabel)
        subloginLabel.snp.makeConstraints{
            $0.left.equalTo(self.nickImageView.snp.right).offset(10)
            $0.bottom.equalTo(self.nickImageView.snp.bottom).offset(-5)
            $0.height.equalTo(30)
        }
        
        //添加tag
        self.addSubview(tagView)
        tagView.snp.makeConstraints{
            $0.left.equalTo(15)
            $0.right.equalToSuperview().offset(-15)
            $0.bottom.equalTo(-15)
            $0.height.equalTo(100)
        }
    }
}


private class TagView:UIView{
    
    private let titleArray = ["金币","阅读劵","收藏"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createBtn()
    }
    
    
    func createBtn()  {
        let margin = (screenWidth-30) / 3
        for index in 0..<titleArray.count{
            
            let button = UIButton.init(frame: CGRect(x: margin*CGFloat(index), y: 20, width: margin, height: 40))
            button.setTitle("0", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.tag = index
            button.addTarget(self, action: #selector(tagBtnClick), for: .touchUpInside)
            self.addSubview(button)
            
            let label = UILabel()
            label.textAlignment = .center
            label.text = titleArray[index]
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.gray
            self.addSubview(label)
            label.snp.makeConstraints{
                $0.centerX.equalTo(button)
                $0.top.equalTo(button.snp.bottom)
                $0.width.equalTo(margin)
            }
        }
        
        //添加分割线
        for index in 0..<titleArray.count-1 {
            let lineView = UIView.init(frame:CGRect(x:margin+CGFloat(index)*margin,y:20, width:0.5, height:60))
            lineView.backgroundColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
            self.addSubview(lineView)
        }
    }
    
    @objc func tagBtnClick(button:UIButton)  {
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
