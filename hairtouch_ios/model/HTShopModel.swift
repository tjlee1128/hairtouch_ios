//
//  HTShopModel.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 14..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation

class HTShopModel: NSObject {
    
    class Review: NSObject {
        var count: Int?
        var grade: String?
    }
    
    var id: Int?
    var shopOwnerId: Int?
    var name: String?
    var phone: String?
    var startTime: String?
    var endTime: String?
    var holiday: String?
    var address: String?
    var mainImage: String?
    var review: Review?
    
}