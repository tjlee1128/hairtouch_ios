//
//  HTDesignerModel.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 14..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation

class HTDesignerModel: NSObject {
    
    class Review: NSObject {
        var count: Int?
        var grade: String?
    }
    
    var id: Int?
    var shopId: Int?
    var name: String?
    var phone: String?
    var startTime: String?
    var endTime: String?
    var reservationType: Int?
    var mainImage: String?
    var review: Review?
}