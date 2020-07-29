//
//  ProjectCell.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/7/15.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import Kingfisher

class ProjectCell: BaseUICollectionViewCell {
    
    private lazy var  labelTitle = UILabel().then({
        $0.text = "label"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 2 //限制2行数
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
        $0.backgroundColor = UIColor.white
    })
    
    private lazy var  labelTime = UILabel().then({
        $0.text = "label"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.numberOfLines = 0 //相当于不限制行数
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
        $0.backgroundColor = UIColor.white
    })
    private lazy var  labelName = UILabel().then({
        $0.text = "弘扬"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.numberOfLines = 1 //相当于不限制行数
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
    })
    
    
    //添加图片
    lazy var projectImageView : UIImageView = {
        let imageView = UIImageView()
        //        imageView.image = UIImage(named: "pic2.jpeg")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func configUI() {
        contentView.backgroundColor = UIColor.white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 5
        
        //添加标题
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints{
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            //和上面的写法一样
            $0.top.equalTo(5)
        }
        
        //添加图片
        contentView.addSubview(projectImageView)
        projectImageView.snp.makeConstraints{
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            //和上面的写法一样
            $0.top.equalTo(labelTitle.snp.bottom).offset(5)
            $0.bottom.equalTo(-30)
        }
        
        //添加作者
        contentView.addSubview(labelName)
        labelName.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-5)
            $0.left.equalToSuperview().offset(5)
        }
        
        //添加时间
//        contentView.addSubview(labelTime)
//        labelTime.snp.makeConstraints{
//            $0.bottom.equalToSuperview().offset(-20)
//            $0.right.equalToSuperview().offset(-10)
//        }
    }
    
    //数据绑定
    var model: ProjectItemModel? {
        didSet {
            guard let model = model else { return }
            labelTitle.text = model.title
            labelName.text = "作者："+(model.author ?? "")
            labelTime.text = model.niceShareDate
            projectImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: model.envelopePic!)!))
        }
    }
}
