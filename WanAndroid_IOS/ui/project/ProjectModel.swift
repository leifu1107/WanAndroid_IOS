//
//  ProjectModel.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/7/15.
//  Copyright © 2020 雷富. All rights reserved.
//

import HandyJSON

struct ProjectModel : HandyJSON {
    var datas : [ProjectItemModel]?
}



struct ProjectItemModel : HandyJSON{
    var title : String?
    var niceShareDate : String?
    var link : String?
    var author : String?
    var envelopePic : String?
}
