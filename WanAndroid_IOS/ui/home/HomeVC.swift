//
//  HomeVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/3/27.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import LLCycleScrollView
import Then
import SnapKit
import SVProgressHUD
import MBProgressHUD
import HandyJSON
import Reusable

class HomeVC: UIViewController{
    // 当前页面
    var page = 0
    
    private var homeLists = [HomeItemModel]()
    private var bannerLists = [BannerModel]()
    
    private lazy var tableView:UITableView = UITableView(frame: .zero, style: .plain).then({
        $0.backgroundColor = UIColor.white
        $0.delegate = self
        $0.dataSource = self
        $0.register(cellType: HomeCell.self)
        $0.alwaysBounceVertical = true
        //        self.automaticallyAdjustsScrollViewInsets = false//去掉顶部(或底部)出现一块空白区域
        //        $0.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        //        $0.scrollIndicatorInsets = $0.contentInset
        
    })
    
    private lazy var bannerView = LLCycleScrollView().then{
        $0.backgroundColor = UIColor.yellow
        //滚动时间间隔 默认2s
        $0.autoScrollTimeInterval = 5
        //等待数据状态占位图
        $0.placeHolderImage = UIImage(named: "normal_placeholder_h")
        //如果没有数据的时候，使用的封面图
        $0.coverImage = UIImage(named: "normal_placeholder_h")
        //设置图片显示方式
        $0.imageViewContentMode = .scaleToFill
        $0.pageControlPosition = .right //圆点位置
        $0.pageControlBottom = 20 //圆点距离底部的距离
        
        $0.frame = CGRect(x: 0, y: 0, width:screenWidth , height: screenWidth/2)//banner大小设置
        //点击事件
        $0.lldidSelectItemAtIndex = didSelectBanner(index:)
    }
    func didSelectBanner(index:NSInteger)  {
        let bannerModel =   bannerLists[index]
        let myWebVC =  MyWebVC(title: bannerModel.title, url: bannerModel.url)
        navigationController?.pushViewController(myWebVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true//隐藏导航栏 发现在viewDidLoad里面无效
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()//发现不这样设置显示不出来
        }
        
        tableView.tableHeaderView = bannerView
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false //去掉顶部(或底部)出现一块空白区域
        }
        //开始请求数据
        //        getNetData()
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
        
        HttpUtils.requestData(url: "article/list/\(page)/json", type: MethodType.get,
                              callBack: {(value:HomeModel?) in
                                //结束刷新
                                if self.tableView.mj_header!.isRefreshing  { self.tableView.mj_header?.endRefreshing() }
                                if self.tableView.mj_footer!.isRefreshing { self.tableView.mj_footer?.endRefreshing() }
                                //是否加载更多
                                if(loadMore){
                                    self.homeLists.append(contentsOf: value?.datas ?? [])
                                }else{
                                    self.homeLists = value?.datas ?? []
                                }
                                self.tableView.reloadData()
                                
        })
        
        
        
        
        //加载banner数据
        HttpUtils.requestData(url: "banner/json", type: MethodType.get,
                              callBack: {(value:Array<BannerModel>?) in
                                self.bannerLists = value ?? []
                                self.bannerView.imagePaths = value?.map{$0.imagePath} as! Array<String>
                                self.bannerView.titles = value?.map{ $0.title!} ?? []
                                
        })
        
        
    }
    
}

extension HomeVC:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyLog(log: "homeLists.count\(homeLists.count)")
        return homeLists.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(for: indexPath, cellType: HomeCell.self)
        cell.model = homeLists[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //跳转到webview
        let myWebVC = MyWebVC()
        myWebVC.title = homeLists[indexPath.row].title
        myWebVC.url = homeLists[indexPath.row].link
        
        navigationController?.pushViewController(myWebVC, animated: true)
    }
    
}
