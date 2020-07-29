//
//  Uibutton+Extensions.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/6/5.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
/*
 文字在图片的上下左右
 - parameter top    :
 - parameter bottom  :
 - parameter left   :
 - parameter right  : 
 */
enum TitlePosition{
    case Top
    case Bottom
    case Left
    case Right
}
extension UIButton{
    
    func set(image : UIImage?, title: String,titlePosition: TitlePosition, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(image, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, space: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: TitlePosition,
                                             space: CGFloat) {
        //        let imageSize = self.imageRect(forContentRect: self.frame)
        //        let titleFont = self.titleLabel?.font!
        //        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        //
        //        var titleInsets: UIEdgeInsets
        //        var imageInsets: UIEdgeInsets
        //
        //        switch (position){
        //        case .Top:
        //            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),left: -(imageSize.width), bottom: 0, right: 0)
        //            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        //        case .Bottom:
        //            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),left: -(imageSize.width), bottom: 0, right: 0)
        //            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        //        case .Left:
        //            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
        //            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,right: -(titleSize.width * 2 + spacing))
        //        case .Right:
        //            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
        //            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //        default:
        //            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //        }
        //
        //        self.titleEdgeInsets = titleInsets
        //        self.imageEdgeInsets = imageInsets
        
        switch position {
        case .Top:
            let titleHeight = titleLabel?.bounds.height ?? 0
            let imageHeight = imageView?.bounds.height ?? 10
            let imageWidth = imageView?.bounds.width ?? 0
            let titleWidth = titleLabel?.bounds.width ?? 0
            titleEdgeInsets = UIEdgeInsets(top: (titleHeight + space) * 0.5,
                                           left: -imageWidth * 0.5,
                                           bottom: -space,
                                           right: imageWidth * 0.5)
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: titleWidth * 0.5,
                                           bottom: (imageHeight + space),
                                           right: -titleWidth * 0.5)
            print("TitlePosition--imageWidth---\(imageWidth)")

        case .Bottom:
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
            
        case .Left:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space)
        case .Right:
            let imageWidth = (imageView?.bounds.width ?? 0) + space
            let titleWidth = (titleLabel?.bounds.width ?? 0) + space
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: 0, right: imageWidth)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth, bottom: 0, right: -titleWidth)
        }
        
        
    }
    
}
