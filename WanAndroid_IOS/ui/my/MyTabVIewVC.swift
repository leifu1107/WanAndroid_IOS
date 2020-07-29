//
//  MyTabVIewVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/7/9.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import Reusable
import SVProgressHUD
import MBProgressHUD
import Toast_Swift

class MyTabViewVC: UIViewController {
    
    lazy var tableView = UITableView(frame: self.view.bounds, style: .grouped).then({
        $0.delegate = self
        $0.dataSource = self
        if #available(iOS 11.0, *) {
            $0.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        $0.register(cellType: MyTabCell.self)
        $0.register(headerFooterViewType: MyHeaderView.self)
    })
    
    private lazy var dataSource: Array = {
        return [[["icon":"mine_accout", "title": "消费记录"],
                 ["icon":"mine_seal", "title": "我的封印图"]],
                
                [["icon":"mine_message", "title": "我的消息/优惠券"],
                 ["icon":"mine_freed", "title": "在线阅读免流量"]],
                
                [["icon":"mine_feedBack", "title": "帮助中心"],
                 ["icon":"mine_mail", "title": "我要反馈"],
                 ["icon":"mine_judge", "title": "给我们评分"],
                 ["icon":"mine_author", "title": "成为作者"],
                 ["icon":"mine_setting", "title": "退出"]]]
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false//隐藏导航栏 发现在viewDidLoad里面无效
        // 设置 title
        self.parent?.navigationItem.title = "我的";
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let navHeight = (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: navHeight, left: 0, bottom: 50, right: 0))//发现不这样设置显示不出来
        }
    }
    
    @objc func btnLoginClick()  {
        self.navigationController?.pushViewController(LoginVC(), animated: true)
    }
}

extension MyTabViewVC : UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0{
            return 265
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myHeaderView =  tableView.dequeueReusableHeaderFooterView(MyHeaderView.self)
        myHeaderView?.nickImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(btnLoginClick)))
        return myHeaderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =   tableView.dequeueReusableCell(for: indexPath, cellType: MyTabCell.self)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .gray
        let sectionArray = dataSource[indexPath.section]
        let dict: [String: String] = sectionArray[indexPath.row]
        cell.imageView?.image =  UIImage(named: dict["icon"] ?? "")
        cell.textLabel?.text = dict["title"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        SVProgressHUD.showInfo(withStatus: "row!\(indexPath.row)")
        //        HUD.showText("row!\(indexPath.row)")
        //        HUD.show(info: "row!\(indexPath.row)---\(indexPath.section)")
        self.view.makeToast("row!\(indexPath.row)---\(indexPath.section)")
        if indexPath.section==2&&indexPath.row == 4 {
            if #available(iOS 8.0, *){
                let alert = UIAlertController(title: "提示", message: "确定退出登录吗?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: {(action) in
                    print("点击了确定")
                    self.navigationController?.pushViewController(LoginVC(), animated: true)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
