//
//  AppDelegate.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/3/27.
//  Copyright © 2020 雷富. All rights reserved.
//不要他了
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    
    var window: UIWindow?//这个是个坑，不写全局变量会黑屏不显示
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initConfig()
        
        let contentView = MainViewController()
        //创建window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        //设置window的rootViewController
        self.window?.rootViewController = UINavigationController.init(rootViewController: contentView)
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func initConfig(){
        HUD.config()
    }
}

