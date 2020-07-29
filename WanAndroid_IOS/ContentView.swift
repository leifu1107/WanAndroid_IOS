//
//  ContentView.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/3/27.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import JXSegmentedView
class ContentView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label =  UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        let label =  UILabel(frame: UIScreen.main.bounds)
        label.text="测试grid"
        self.view.addSubview(label)
        self.view.backgroundColor=UIColor.white

    }
    

}

extension ContentView:JXSegmentedListContainerViewListDelegate{
    func listView() -> UIView {
        view
    }
}

