//
//  KnowledgeTabVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/5/22.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import Tabman
import Pageboy
class KnowledgeTabVC: TabmanViewController {
    
    
    var tabTitles : [String] = []
    var tabIds : [Int] = []
    
    var viewControllers: [UIViewController] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false//隐藏导航栏 发现在viewDidLoad里面无效
        // 设置 title
        self.parent?.navigationItem.title = "体系";
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tab数据
        //        var tabItems: [TMBarItem] = []
        
        self.dataSource = self
        // Create bar
        let bar = TMBar.ButtonBar()
        //设置导航上下左右间距
        bar.layout.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        //两个导航文字的间隔
        bar.layout.interButtonSpacing = 30
//        bar.layout.contentMode = .fit
//        bar.layout.transitionStyle = .snap // Customize
    
        //背景颜色
        bar.backgroundColor = UIColor.white
        //设置导航颜色
        bar.indicator.tintColor = UIColor.black
    
       
//        bar.layoutGuides
        
//       automaticallyAdjustsChildInsets = true
        
        
        //        bar.fadesContentEdges = true
        //        bar.spacing = 36
        
        
        //设置导航文字颜色
        bar.buttons.customize{ (button) in
            button.selectedTintColor = UIColor.black
            button.tintColor = UIColor.black.withAlphaComponent(0.5)
            
        }
        // Add to view
        addBar(bar.systemBar(), dataSource: self, at: .top)
        
        getNetData()
        
    }
    
    func getNetData() {
        
        //加载体系tab列表
        HttpUtils.requestData(url: "tree/json", type: MethodType.get,
                              callBack: {(value:Array<KnowledgeTabModel>?) in
                                
                                value?.map{
                                    for child in $0.children ?? []{
                                        self.tabTitles.append(child.name ?? "")
                                        self.tabIds.append(child.id)
                                    }
                                }
                                
                                for tabId in self.tabIds {
                                    // VC 数据
                                    self.viewControllers.append(KnowledgeVC())
                                }
                                self.reloadData()
                                
        })
    }
    
}

extension KnowledgeTabVC:PageboyViewControllerDataSource,TMBarDataSource{
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: tabTitles[index])
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
