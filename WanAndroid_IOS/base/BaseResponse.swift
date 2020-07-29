//
//  BaseResponse.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/4/9.
//  Copyright © 2020 雷富. All rights reserved.
//

import HandyJSON
class BaseResponse<T:HandyJSON>: HandyJSON {
    
    var errorCode : Int?    //服务返回码
    
    var errorMsg : String?
    
    var data : T?
    
    
    public required init() {}
}
class BaseResponseArray<T:HandyJSON>: HandyJSON {
    
    var errorCode : Int?    //服务返回码
    
    var errorMsg : String?
    
    var data : [T]?
    
    
    public required init() {}
}

extension Array: HandyJSON{}
