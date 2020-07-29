//
//  UILable+Extensions.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/6/1.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit

extension UILabel{
    
    
    /**
     UILabel遍历构造器
     - parameter text    : 文字
     - parameter textColor  : 文字颜色
     - parameter fontSize   : 文字大小
     - parameter numOfLines  : 文字行数
     - parameter alignment : 对齐方式
     */
    convenience init(text:String?,
                     _ textColor:UIColor = UIColor.darkGray,
                     _ fontSize:CGFloat = 16,
                     _ numOfLines:Int = 0,
                     _ alignment:NSTextAlignment = .left) {
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.numberOfLines = numOfLines
        self.textAlignment = alignment
        
        self.sizeToFit()
    }
}

/**
      //UILabel自适应高度
      - parameter label    : UILabel控件
      - parameter width  : 文字显示的宽度
      - parameter style   : 文字样式（包括行高，字间距等，不设置计算会不准确）
 
        let style = NSMutableParagraphStyle.init()
          //行间距
          style.lineSpacing = 10
          
          label.attributedText = NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: style])
        //高度自适应
          let boundingRect = autoLabel(label: label,width: screenWidth-40,style: style)
          label.frame = CGRect(x: 20, y: navHeight+100, width: boundingRect.width, height: boundingRect.height)
      */
  func autoLabel(label:UILabel , width:CGFloat,style:NSMutableParagraphStyle)-> CGRect{
      let options: NSStringDrawingOptions = .usesLineFragmentOrigin
      let str: NSString = label.text! as NSString
      let boundingRect = str.boundingRect(with: CGSize(width: width, height: 0), options: options, attributes: [NSAttributedString.Key.font:label.font, NSAttributedString.Key.paragraphStyle:style], context: nil)
      return boundingRect
  }
