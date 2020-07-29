//
//  LayoutButton.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/6/4.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit

/**
 图片在文字的上下左右
 - parameter top    : 图片在文字的上
 - parameter bottom  : 图片在文字的下
 - parameter left   : 图片在文字的上下左
 - parameter right  : 图片在文字的右
 */
enum POSITION{
    case top
    case bottom
    case left
    case right
}
/**
 - parameter position    : 图片在文字的上下左右
 - parameter space  : 图片与文字的间隔
 */
class LayoutButton: UIButton {
    
    var position:POSITION?
    var space:CGFloat = 0
    convenience init(_ position:POSITION,space :CGFloat = 0){
        self.init(type: .custom)
        self.position = position
        self.space = space
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let positon = position{
            switch positon {
            case .top:
                let titleHeight = titleLabel?.bounds.height ?? 0
                let titleWith = titleLabel?.bounds.width ?? 0
                let imageHeight = imageView?.bounds.height ?? 0
                let imageWith = imageView?.bounds.width ?? 0
                titleEdgeInsets = UIEdgeInsets(top: (titleHeight+space)*0.5, left: -imageWith*0.5, bottom: -space, right: imageWith*0.5)
                imageEdgeInsets = UIEdgeInsets(top: 0, left: titleWith*0.5, bottom: imageHeight+space, right: -titleWith*0.5)
                
            case .bottom:
                let titleHeight = titleLabel?.bounds.height ?? 0
                let imageHeight = imageView?.bounds.height ?? 0
                let imageWidth = imageView?.bounds.width ?? 0
                let titleWidth = titleLabel?.bounds.width ?? 0
                titleEdgeInsets = UIEdgeInsets(top: -(titleHeight + space) * 0.5,
                                               left: -imageWidth * 0.5,
                                               bottom: space,
                                               right: imageWidth * 0.5)
                imageEdgeInsets = UIEdgeInsets(top: (imageHeight + space),
                                               left: titleWidth * 0.5,
                                               bottom: 0,
                                               right: -titleWidth * 0.5)
                
            case .left:
                titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: 0)
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space)
            case .right:
                let imageWidth = (imageView?.bounds.width ?? 0) + space
                let titleWidth = (titleLabel?.bounds.width ?? 0) + space
                titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: 0, right: imageWidth)
                imageEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth, bottom: 0, right: -titleWidth)
                
            }
        }
        
    }
    
    
    //    private var rightTitleButton = LayoutButton(.right, space: 10).then {
    //        $0.setTitle("查看全部", for: .normal)
    //        $0.setTitleColor(#colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1), for: .normal)
    //        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15.auto(), weight: .regular)
    //        let image = #imageLiteral(resourceName: "home_arrows_lucky").scaled(toWidth: 6.auto())
    //        $0.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
    //        $0.tintColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
    //        $0.contentEdgeInsets = UIEdgeInsets(0, 10.auto(), 0, 10.auto())
    //    }
}
