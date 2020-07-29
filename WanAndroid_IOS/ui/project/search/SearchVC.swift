//
//  SearchVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/7/22.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let datas = ["妲己","狄仁杰","典韦","貂蝉","达摩","大乔","东皇太一","高渐离","关羽","宫本武藏","干将莫邪","鬼谷子","宫本武藏+热门","干将莫邪-鬼谷子"]
    
    private lazy var  labelTitle = UILabel().then({
        $0.text = "热门搜索"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
        $0.backgroundColor = UIColor.white
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title =  "搜索"

        self.view.addSubview(labelTitle)
        labelTitle.snp.makeConstraints({
            $0.top.equalTo(100)
            $0.left.equalTo(15)
        })
        
        //添加tag标签
        var frameX:CGFloat = 15
        var frameY:CGFloat = 130
        for index in 0..<datas.count{
            let tag = UILabel()
            tag.text = datas[index]
            tag.backgroundColor = UIColor.darkGray
            tag.textColor = UIColor.white
            tag.layer.masksToBounds = true
            tag.layer.cornerRadius = 5
            tag.textAlignment = .center
            self.view.addSubview(tag)
            
            let str =  datas[index]
            let width:CGFloat = CGFloat((str.count+2)*15)
            let height:CGFloat = 30
            //超过一行换行,frameX初始值为左边距离
            if (frameX+width < screenWidth) {
                tag.frame = CGRect(x: frameX, y: frameY, width: width, height: height)
                frameX = tag.frame.maxX+10
            }else{
                frameX = 15
                frameY+=45
                tag.frame = CGRect(x: frameX, y: frameY, width: width, height: height)
                frameX = tag.frame.maxX+10
            }
        }
        
    }
}
