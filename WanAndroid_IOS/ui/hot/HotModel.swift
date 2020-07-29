//
//  HotModel.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/6/2.
//  Copyright © 2020 雷富. All rights reserved.
//

import HandyJSON


struct HotModel:HandyJSON {
    var datas : [HotItemModel]?
}

struct HotItemModel : HandyJSON{
    var title : String?
    var niceShareDate : String?
    var link : String?
    var shareUser : String?
}


