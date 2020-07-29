//
//  HomeCell.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/4/15.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit

class HomeCell: BaseTableViewCell{
    
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
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.numberOfLines = 0 //相当于不限制行数
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
        $0.backgroundColor = UIColor.white
    })
    
    override func configUI() {
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints{
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(100)
            
        }
        contentView.addSubview(labelTime)
        
        labelTime.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(10)
        }
    }
    
    var model: HomeItemModel? {
        didSet {
            guard let model = model else { return }
            labelTitle.text = model.title
            labelTime.text = model.niceDate
        }
    }
}
