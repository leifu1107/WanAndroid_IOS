//
//  BaseUICollectionViewCell.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/7/15.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import Reusable

class BaseUICollectionViewCell: UICollectionViewCell ,Reusable{
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configUI()
    }
    
    open func configUI(){}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
