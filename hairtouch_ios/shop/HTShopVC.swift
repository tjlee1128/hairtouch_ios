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
    
    var shopModelArray = [HTShopModel]()
    
//    let parameters = ["mainregion": "1", "subregion": "2"]
    
    override func viewDidLoad() {
        Alamofire.request(.GET, "http://hairtouch.dev/shops.json", parameters: nil)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let shops = JSON as? NSArray {
                        for shop in shops {
                            if let dictionary = shop as? NSDictionary {
                                let shopModel = HTShopModel()
                                shopModel.id = dictionary["id"] as? Int
                                shopModel.shopOwnerId = dictionary["shop_owner_id"] as? Int
                                shopModel.name = dictionary["name"] as? String
                                shopModel.phone = dictionary["phone"] as? String
                                shopModel.startTime = dictionary["start_time"] as? String
                                shopModel.endTime = dictionary["end_time"] as? String
                                shopModel.holiday = dictionary["holiday"] as? String
                                shopModel.address = dictionary["address"] as? String
                                shopModel.mainImage = dictionary["main_image"] as? String
                                
                                if let shopReview = dictionary["review"] as? NSDictionary {
                                    let shopReviewModel = HTShopModel.Review()
                                    shopReviewModel.count = shopReview["count"] as? Int
                                    shopReviewModel.grade = shopReview["grade"] as? String
                                    
                                    shopModel.review = shopReviewModel
                                }
                                self.shopModelArray.append(shopModel)
                            }
                        }
                    }
                }
                self.shopTableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopModelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShopCell", forIndexPath: indexPath) as! HTShopTableViewCell

        cell.gradeLabel.text = String(format: "평점 : %.2f", (Float(self.shopModelArray[indexPath.row].review!.grade!))!)
        cell.countLabel.text = "리뷰 수 : \(self.shopModelArray[indexPath.row].review!.count!)"
        cell.nameLabel.text = self.shopModelArray[indexPath.row].name
        cell.addressLabel.text = self.shopModelArray[indexPath.row].address
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "shop", bundle: nil).instantiateViewControllerWithIdentifier("HTShopDetailVC") as! HTShopDetailVC
        vc.shopId = self.shopModelArray[indexPath.row].id!
        vc.name = self.shopModelArray[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
