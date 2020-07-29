//
//  ProjectVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/7/15.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import Then
import SnapKit
import SVProgressHUD
import MBProgressHUD
import HandyJSON
import Reusable
class ProjectVC: UIViewController {
    // 当前页面
    var page = 0
    //文章id
    var cid : Int = 294
    //实体类数组
    private var mList = [ProjectItemModel]()
    
    
    let layout = UICollectionViewFlowLayout().then({
        //竖直方向是上下的间距
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
        $0.scrollDirection = .vertical
        $0.itemSize = CGSize(width: screenWidth/2-7.5, height: 280)
    })
    
    lazy var collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout).then({
        $0.backgroundColor = UIColor.background
        $0.delegate = self
        $0.dataSource = self
        if #available(iOS 11.0, *) {
            $0.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        $0.register(cellType: ProjectCell.self)
        
    })
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false//隐藏导航栏 发现在viewDidLoad里面无效
        // 设置 title
        self.parent?.navigationItem.title = "项目";
        //右边按钮或者文字
        let btnItem =  UIBarButtonItem.init(image: UIImage(named: "search_32px"),  style: .plain, target: self, action: #selector(clickSearch))
        btnItem.tintColor = UIColor.black
        self.parent?.navigationItem.rightBarButtonItem = btnItem
    }
    /**
     除了项目页面有搜索，其他页面搜索隐藏
     */
    override func viewDidDisappear(_ animated: Bool) {
        self.parent?.navigationItem.rightBarButtonItem = nil
    }
    // 去搜索页面
    @objc func clickSearch(){
        self.navigationController?.pushViewController(SearchVC(), animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let navHeight = (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        self.view.addSubview(collectionView)
        self.view.backgroundColor = UIColor.background
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: navHeight+5, left: 5, bottom: 0, right: 5))//发现不这样设置显示不出来
        }
        // 添加刷新控件
        setRefresh()
    }
    
    func  setRefresh() {
        let header = RefreshHeader{ [weak self] in
            self?.getNetData(false)
        }
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel?.isHidden = true
        collectionView.mj_header = header
        header.beginRefreshing()
        
        collectionView.mj_footer =  RefreshAutoGifFooter{ [weak self] in
            self?.getNetData(true)
        }
        collectionView.mj_footer?.isAutomaticallyChangeAlpha = true
    }
    
    
    func getNetData(_ loadMore : Bool = false) {
        if(!loadMore){
            page = 0
        }else{
            page += 1
        }
        
        HttpUtils.requestData(url: "project/list/\(page)/json?cid=\(cid)", type: MethodType.get,
                              callBack: {(value:ProjectModel?) in
                                //结束刷新
                                if self.collectionView.mj_header!.isRefreshing  { self.collectionView.mj_header?.endRefreshing() }
                                if self.collectionView.mj_footer!.isRefreshing { self.collectionView.mj_footer?.endRefreshing() }
                                //是否加载更多
                                if(loadMore){
                                    self.mList.append(contentsOf: (value?.datas ?? []))
                                    if value?.datas?.isEmpty ?? true {
                                        self.collectionView.mj_footer?.endRefreshingWithNoMoreData()
                                        SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
                                        return
                                    }
                                }else{
                                    self.mList = value?.datas ?? []
                                }
                                self.collectionView.reloadData()
                                
        })
    }
}

extension ProjectVC :UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProjectCell.self)
        cell.model = mList[indexPath.row]
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    //        return CGSize(width: screenWidth/3 - 10, height: 100)
    //    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //跳转到webview
        let myWebVC =  MyWebVC(title: mList[indexPath.row].title, url: mList[indexPath.row].link)
        navigationController?.pushViewController(myWebVC, animated: true)
    }
}
