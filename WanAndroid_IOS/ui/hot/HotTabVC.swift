//
//  HotTabVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/5/25.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import JXSegmentedView

class HotTabVC : UIViewController {
    
    let segmentedView=JXSegmentedView()
    let segmentedDataSource = JXSegmentedTitleDataSource()
    
    //配置指示器
    let indicator = JXSegmentedIndicatorLineView()
    
    
    lazy var listContainerView:JXSegmentedListContainerView = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    var tabTitles : [String] = []
    var tabIds : [Int] = []
    
    var viewControllers: [UIViewController] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false//隐藏导航栏 发现在viewDidLoad里面无效
        // 设置 title
        self.parent?.navigationItem.title = "热门";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //网络请求
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
                                    self.viewControllers.append(HotVC(tabId))
                                }
                                self.configTab()
                                
        })
    }
    
    func configTab()  {
           self.segmentedDataSource.titles=self.tabTitles
           
           //        segmentedDataSource.titles = ["热门1","热门2","热门2","热门2","热门2","热门2","热门2","热门2","热门2"]
           segmentedView.dataSource = segmentedDataSource
           view.addSubview(segmentedView)
           
           indicator.indicatorWidth = 20
           segmentedView.indicators = [indicator]
           
           segmentedView.listContainer = listContainerView
           view.addSubview(listContainerView)
       }
       
       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           let navHeight = (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
            //本地存储导航高度
            UserDefaults.standard.set(navHeight, forKey: "navHeight")
        
           segmentedView.frame = CGRect(x: 0, y: navHeight, width: view.bounds.size.width, height: 50)
           listContainerView.frame = CGRect(x: 0, y: navHeight+50, width: view.bounds.size.width, height: view.bounds.size.height-navHeight-50)
       }
}


extension HotTabVC : JXSegmentedListContainerViewDataSource{
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        segmentedDataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return self.viewControllers[index] as! HotVC
    }
}
