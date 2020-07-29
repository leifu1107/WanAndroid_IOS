//
//  ViewController.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/26.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController ,UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabs();
        
        // 这样设置就有效果了。 但是看到源码注释的意思是针对整个TabBar的设置的  - -!
        UITabBar.appearance().tintColor = UIColor.red
        //右边按钮或者文字
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "home_tabbar_night_32x32_"),  style: .done, target: self, action: #selector(clickSearch))
//        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.navigationController?.isToolbarHidden = true
        
    }

    
    // 去搜索页面
    @objc func clickSearch(){
        //self.navigationController?.pushViewController(SearchArcticleViewController(), animated: true)
    }
    
    // 创建 tabs
    func createTabs(){
        // 主页 Tab VC
        let homeVC = HomeVC();
        homeVC.tabBarItem = UITabBarItem(title: "主页",  image: UIImage(named: "home_tabbar_night_32x32_"),
                                      selectedImage: UIImage(named: "home_tabbar_press_32x32_"));
        
        let homeNVC = UINavigationController(rootViewController: homeVC);
        //        homeNVC.navigationItem.title = "主页";
        
        
        // 知识体系
        let knowledgeVC = ProjectVC();
        knowledgeVC.tabBarItem = UITabBarItem(title: "项目",  image: UIImage(named: "huoshan_tabbar_night_32x32_"),
                                      selectedImage: UIImage(named: "huoshan_tabbar_press_32x32_"));
        let knowledgeNVC = UINavigationController(rootViewController: knowledgeVC);
                 
        // 热门
        let hotVC = HotTabVC();
        hotVC.tabBarItem = UITabBarItem(title: "热门", image: UIImage(named: "weitoutiao_tabbar_night_32x32_"),
                                      selectedImage: UIImage(named: "weitoutiao_tabbar_press_32x32_"));
        let hotNVC = UINavigationController(rootViewController: hotVC);
        
    
        // 我的
        let myVC = MyTabViewVC()
        myVC.tabBarItem = UITabBarItem(title: "我的",  image: UIImage(named: "mine_tabbar_night_32x32_"),
                                      selectedImage: UIImage(named: "mine_tabbar_press_32x32_"))
        let myNVC = UINavigationController(rootViewController: myVC)
        
                
        self.viewControllers = [homeVC, knowledgeVC, hotVC, myVC];
    }
    

    
    
    
}

