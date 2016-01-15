//
//  HTRegionVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 14..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HTRegionVC: HTViewController {
    
    var delegate: MainDelegate?
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(animated: Bool) {
        self.delegate!.refreshData!()
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
