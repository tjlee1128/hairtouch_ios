//
//  HTShopVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 12..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HTShopVC: HTViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var shopTableView: UITableView!
    
    // refactoring
    var shopArray = [[String: AnyObject]]()
    
    // life cycle
    override func viewDidLoad() {
        Alamofire.request(.GET, "http://hairtouch.dev/shops.json", parameters: nil)
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
                
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
                
                self.shopArray = response.result.value as! Array
                self.shopTableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShopCell", forIndexPath: indexPath) as! HTShopTableViewCell

//        print(String(format: "평점 %.2f", ((grade as String) as NSString).floatValue))
        
        // refactoring
        var shopDictionary = [String: AnyObject]()
        shopDictionary = self.shopArray[indexPath.row] as Dictionary
        var shopReviewDictionary = [String: AnyObject]()
        shopReviewDictionary = shopDictionary["review"] as! Dictionary
        
        let first = (shopReviewDictionary["grade"] as! String)
        let second = first as NSString
        let third = String(format: "%.2f", second.floatValue)
        print(third)
        cell.countLabel.text = "리뷰 수 \(shopReviewDictionary["count"] as! Int)"
        cell.nameLabel.text = shopDictionary["name"] as? String
        cell.addressLabel.text = shopDictionary["address"] as? String
        
        return cell
    }
    
    
    // UITableViewDelegate delegate functions
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "shop", bundle: nil).instantiateViewControllerWithIdentifier("HTShopDetailVC") as! HTShopDetailVC
        let shopInfo = self.shopArray[indexPath.row]
        vc.shopId = shopInfo["id"] as? Int
        vc.name = shopInfo["name"] as? String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // action
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
