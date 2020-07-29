//
//  HotVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/5/29.
//  Copyright © 2020 雷富. All rights reserved.
//

import SwiftUI
import Then
import SnapKit
import SVProgressHUD
import MBProgressHUD
import HandyJSON
import Reusable
import JXSegmentedView


class HotVC: UIViewController {
    
    // 当前页面
    var page = 0
    //文章id
    var cid : Int = 0
    //实体类数组
    private var mList = [HotItemModel]()
    
    private lazy var tableView:UITableView = UITableView().then({
        $0.backgroundColor = UIColor.white
        $0.delegate = self
        $0.dataSource = self
        $0.register(cellType: HotCell.self)
        $0.alwaysBounceVertical = true
        //去掉分割线
        $0.separatorStyle = .none
    })
    
    
    convenience init(_ id: Int) {
        self.init()
        self.cid = id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let navHeight  = UserDefaults.standard.float(forKey: "navHeight")
        view.addSubview(tableView)
        tableView.snp.makeConstraints {            
            //下面等效$0.top.equalToSuperview().offset(10)  left bottom right  下面是简写
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))//发现不这样设置显示不出来
        }
        
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false //去掉顶部(或底部)出现一块空白区域
        }
        // 添加刷新控件
        setRefresh()
    }
    
    func  setRefresh() {
        let header =   RefreshHeader{ [weak self] in
            self?.getNetData(false)
        }
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header = header
        header.beginRefreshing()
        
        tableView.mj_footer =  RefreshAutoGifFooter{ [weak self] in
            self?.getNetData(true)
        }
        tableView.mj_footer?.isAutomaticallyChangeAlpha = true
    }
    
    
    func getNetData(_ loadMore : Bool = false) {
        if(!loadMore){
            page = 0
        }else{
            page += 1
        }
        
        HttpUtils.requestData(url: "article/list/\(page)/json?cid=\(cid)", type: MethodType.get,
                              callBack: {(value:HotModel?) in
                                //结束刷新
                                if self.tableView.mj_header!.isRefreshing  { self.tableView.mj_header?.endRefreshing() }
                                if self.tableView.mj_footer!.isRefreshing { self.tableView.mj_footer?.endRefreshing() }
                                //是否加载更多
                                if(loadMore){
                                    self.mList.append(contentsOf: (value?.datas ?? []))
                                    if value?.datas?.isEmpty ?? true {
                                        self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                                        SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
                                        return
                                    }
                                }else{
                                    self.mList = value?.datas ?? []
                                }
                                self.tableView.reloadData()
                                
        })
    }
}

extension HotVC:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(for: indexPath, cellType: HotCell.self)
        cell.model = mList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //跳转到webview
        let myWebVC = MyWebVC()
        myWebVC.title = mList[indexPath.row].title
        myWebVC.url = mList[indexPath.row].link
        
        navigationController?.pushViewController(myWebVC, animated: true)
    }
    //cell边框设置
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        cell.layer.borderWidth = 5
    //        cell.layer.borderColor = UIColor.gray.cgColor
    //        cell.layer.cornerRadius = 10
    //    }
}
extension HotVC:JXSegmentedListContainerViewListDelegate{
    func listView() -> UIView {
        view
    }
}
