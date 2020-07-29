//
//  BannerModel.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/4/9.
//  Copyright © 2020 雷富. All rights reserved.
//

import HandyJSON
struct BannerModel:HandyJSON {
    var imagePath : String?
    var title : String?
    var url : String?
}



struct HomeModel:HandyJSON {
    var datas : [HomeItemModel]?
}
struct HomeItemModel:HandyJSON {
    //    "title" : "关于 Android Service，你该知道的都在这了。",
    //    "fresh" : true,
    //    "chapterId" : 502,
    //    "apkLink" : "",
    //    "zan" : 0,
    //    "canEdit" : false,
    //    "descMd" : "",
    //    "origin" : "",
    //    "projectLink" : "",
    //    "type" : 0,
    //    "superChapterName" : "广场Tab",
    //    "id" : 12907,
    //    "prefix" : "",
    //    "courseId" : 13,
    //    "audit" : 1,
    //    "chapterName" : "自助",
    //    "publishTime" : 1587001305000,
    //    "superChapterId" : 494,
    //    "niceShareDate" : "6小时前",
    //    "collect" : false,
    //    "shareDate" : 1587001305000,
    //    "desc" : "",
    //    "niceDate" : "6小时前",
    //    "visible" : 1,
    //    "author" : "",
    
    var id : String?
    var title : String?
    var niceDate : String?
    var desc : String?
    var url : String?
    var link : String?
}



