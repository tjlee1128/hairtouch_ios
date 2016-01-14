//
//  MainVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 12..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit

class MainVC: HTViewController {
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    
    @IBAction func storeAction(sender: AnyObject) {
        let shopVC = (UIStoryboard(name: "shop", bundle: nil).instantiateViewControllerWithIdentifier("HTShopVC"))
        self.navigationController?.pushViewController(shopVC, animated: true)
    }
    @IBAction func designerAction(sender: AnyObject) {
        let designerVC = (UIStoryboard(name: "designer", bundle: nil).instantiateViewControllerWithIdentifier("HTDesignerVC"))
        self.navigationController?.pushViewController(designerVC, animated: true)
    }
    @IBAction func procedureAction(sender: AnyObject) {
    }
    @IBAction func mypageAction(sender: AnyObject) {
    }
    
}