//
//  HTShopDetailVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 12..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit

class HTShopDetailVC: HTViewController {
    
    var name: String?
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        self.titleLabel.text = self.name
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}