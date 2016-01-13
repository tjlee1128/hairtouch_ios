//
//  HTShopDetailVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 12..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HTShopDetailVC: HTViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shopId: Int?
    var name: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shopInfoView: UIView!
    @IBOutlet weak var designerTableView: UITableView!
    
    var shopDetailDictionary = [String: AnyObject]()
    var designerArray = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        self.titleLabel.text = self.name
        
        Alamofire.request(.GET, "http://hairtouch.dev/shops/\(self.shopId! as Int).json", parameters: nil)
            .responseJSON { response in
                self.shopDetailDictionary = response.result.value as! Dictionary
                self.designerArray = self.shopDetailDictionary["designers"] as! Array
                
                self.designerTableView.reloadData()
        }
    }
    
    //
    //
    // tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.designerArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DesignerCell", forIndexPath: indexPath) as! HTDesignerTableViewCell
        
        var designerDictionary = [String: AnyObject]()
        designerDictionary = self.designerArray[indexPath.row] as Dictionary
        var designerReviewDictionary = [String: AnyObject]()
        designerReviewDictionary = designerDictionary["review"] as! Dictionary
        
        cell.countLabel.text = "리뷰 수 \(designerReviewDictionary["count"] as! Int)"
        cell.nameLabel.text = designerDictionary["name"] as? String
        
        return cell;
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    //
    //
    // action
    
    @IBAction func shopInfoAction(sender: AnyObject) {
        self.shopInfoView.hidden = false
        self.designerTableView.hidden = true
    }
    
    @IBAction func designerInfoAction(sender: AnyObject) {
        self.shopInfoView.hidden = true
        self.designerTableView.hidden = false
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}