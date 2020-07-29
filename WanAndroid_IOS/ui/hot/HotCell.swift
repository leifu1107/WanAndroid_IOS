//
//  HotCell.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/6/2.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit

class HotCell: BaseTableViewCell{
    
    private lazy var  labelTitle = UILabel().then({
        $0.text = "label"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18)
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
        $0.backgroundColor = UIColor.white
    })
    
    private lazy var  divLine = UIView().then({
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    })
    
    override func configUI() {
        //添加分割线
        contentView.addSubview(divLine)
        divLine.snp.makeConstraints{
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(10)
        }
        //添加标题
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints{
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            //和上面的写法一样
            $0.top.equalTo(10)
        }
        //添加作者
        contentView.addSubview(labelName)
        labelName.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.left.equalToSuperview().offset(10)
        }
        //添加时间
        contentView.addSubview(labelTime)
        labelTime.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            //            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
    }
    //数据绑定
    var model: HotItemModel? {
        didSet {
            guard let model = model else { return }
            labelTitle.text = model.title
            labelName.text = model.shareUser
            labelTime.text = model.niceShareDate
        }
    }
}

