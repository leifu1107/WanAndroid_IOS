//
//  UIimage+Extensions.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/6/5.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
extension UIImage {
    /**
     *  重设图片大小
     *let image = UIImage(named:"img.jpg")
     *@IBOutlet weak var imageView: UIImageView!
     
     *let reSize = CGSize(width: 240, height: 150)
     imageView.image = image?.reSizeImage(reSize)
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}
