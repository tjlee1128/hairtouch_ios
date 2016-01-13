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
    
    var shops = []
    
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
                
                self.shops = response.result.value as! NSArray
                
                self.shopTableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.shops.count > 0 {
            return self.shops.count
        } else {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShopCell", forIndexPath: indexPath) as! HTShopTableViewCell
        
        let shopInfo = self.shops[indexPath.row] as! NSDictionary
        let shopReviewInfo = shopInfo["review"] as! NSDictionary
//        let grade = shopReviewInfo["grade"] as! String
        let count = "\(shopReviewInfo["count"] as! NSInteger)"

//        print(String(format: "평점 %.2f", ((grade as String) as NSString).floatValue))
        cell.countLabel.text = "리뷰 수 \(count)"
        cell.nameLabel.text = shopInfo["name"] as? String
        cell.addressLabel.text = shopInfo["address"] as? String
        
        return cell
    }
    
    
    // UITableViewDelegate delegate functions
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "shop", bundle: nil).instantiateViewControllerWithIdentifier("HTShopDetailVC") as! HTShopDetailVC
        let shopInfo = self.shops.objectAtIndex(indexPath.row)
        vc.name = shopInfo["name"] as? String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // action
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
