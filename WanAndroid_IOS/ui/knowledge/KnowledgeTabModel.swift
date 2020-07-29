//
//  KnowledgeTabModel.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/5/22.
//  Copyright © 2020 雷富. All rights reserved.
//

import HandyJSON
struct KnowledgeTabModel:HandyJSON {
    var name : String? //一级名字
    var id : String?
    var children : [KnowledgeTabChildModel]?
}

struct KnowledgeTabChildModel:HandyJSON{
    var name : String? //一级名字
    var id : Int = 0
    var visible : Int = 0 //不设置默认会报错
}

