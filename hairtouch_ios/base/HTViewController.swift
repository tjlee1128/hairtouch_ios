//
//  HTViewController.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 12..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit

class HTViewController: UIViewController {
    var statusBarHidden: Bool?
    var navigationBarHidden: Bool?
    
    override func viewDidLoad() {
        statusBarHidden = true
        navigationBarHidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}