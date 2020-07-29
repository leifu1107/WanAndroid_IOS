//
//  KnowledgeVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/5/29.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
class KnowledgeVC: UIViewController {
    var navHeight : CGFloat = 0
    
//   lazy var btn =  LayoutButton(.bottom, space: 10).then{
//        $0.setTitle("查看全部", for: .normal)
//        $0.setImage(UIImage(named: "yaofan"), for: .normal)
//        $0.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 60)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navHeight = (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        //        let btn = UIButton()
        //        btn.setTitle("button", for: .normal)
        //        btn.setTitleColor(UIColor.red, for: .normal)
        //        btn.setImage(UIImage(named: "yaofan"), for: .normal)
        //        btn.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 60)
        //
        
        
        let string  = "把第三方库的源码编译成一个包 我们先从上克隆SINQ的项目下来,然后编译,我们可以看到在Products已经输出了一个资源包。现在我们已经把第三方库然后编译,我们可以看到在Products然后编译,我们可以看到在Products然后编译我们可以看到在Products然后编译,我们可以看到在Products然后编译,我们可以看到在Products然后编译,我们可以看到在Products然后编译,我们可以看到在Products然后编译,我们可以看到在Products然后编译,我们可以看到在Products然后编译,我们可以看到在Products"
        let label =  UILabel(text: string)
        
        let style = NSMutableParagraphStyle.init()
        //行间距
        style.lineSpacing = 10
        
        label.attributedText = NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: style])
        
        
        //高度自适应
        let boundingRect = autoLabel(label: label,width: screenWidth-40,style: style)
        label.frame = CGRect(x: 20, y: navHeight+100, width: boundingRect.width, height: boundingRect.height)
        //阴影颜色设置
        label.shadowColor = UIColor.red
        label.shadowOffset = CGSize(width: 0, height: 0.1)
        
//        btn.snp.makeConstraints{
//            $0.top.equalTo(100)
//        }
        
//        self.view.addSubview(btn)
        self.view.backgroundColor=UIColor.white
    }
    
    /**
     //UILabel自适应高度
     - parameter label    : UILabel控件
     - parameter width  : 文字显示的宽度
     - parameter style   : 文字样式（包括行高，字间距等，不设置计算会不准确）
     
     */
    func autoLabel(label:UILabel , width:CGFloat,style:NSMutableParagraphStyle)-> CGRect{
        let options: NSStringDrawingOptions = .usesLineFragmentOrigin
        let str: NSString = label.text! as NSString
        let boundingRect = str.boundingRect(with: CGSize(width: width, height: 0), options: options, attributes: [NSAttributedString.Key.font:label.font, NSAttributedString.Key.paragraphStyle:style], context: nil)
        return boundingRect
    }
    
}
