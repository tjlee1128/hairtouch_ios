//
//  HTDesignerVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 12..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HTDesignerVC: HTViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var designerTableView: UITableView!
    
    var designerArray = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        Alamofire.request(.GET, "http://hairtouch.dev/designers.json", parameters: nil)
            .responseJSON { response in
                self.designerArray = response.result.value as! Array
                self.designerTableView.reloadData()
        }
    }
    
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
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}