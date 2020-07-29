//
//  BaseTableViewCell.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/4/15.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import Reusable

class BaseTableViewCell: UITableViewCell,Reusable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    open func configUI(){}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
