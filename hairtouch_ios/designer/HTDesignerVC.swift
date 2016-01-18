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
    
    var designerModelArray = [HTDesignerModel]()
    
    override func viewDidLoad() {
        Alamofire.request(.GET, "http://10.10.0.162:3000/designers.json", parameters: nil)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let designers = JSON as? NSArray {
                        for designer in designers {
                            if let dictionary = designer as? NSDictionary {
                                let designerModel = HTDesignerModel()
                                designerModel.id = dictionary["id"] as? Int
                                designerModel.shopId = dictionary["shop_id"] as? Int
                                designerModel.name = dictionary["name"] as? String
                                designerModel.phone = dictionary["phone"] as? String
                                designerModel.startTime = dictionary["start_time"] as? String
                                designerModel.endTime = dictionary["end_time"] as? String
                                designerModel.mainImage = dictionary["main_image"] as? String
                                
                                if let designerReview = dictionary["review"] as? NSDictionary {
                                    let designerReviewModel = HTDesignerModel.Review()
                                    designerReviewModel.count = designerReview["count"] as? Int
                                    designerReviewModel.grade = designerReview["grade"] as? String
                                    
                                    designerModel.review = designerReviewModel
                                }
                                self.designerModelArray.append(designerModel)
                            }
                        }
                    }
                }
                self.designerTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.designerModelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DesignerCell", forIndexPath: indexPath) as! HTDesignerTableViewCell
        
        cell.gradeLabel.text = String(format: "평점 : %.2f", (Float(self.designerModelArray[indexPath.row].review!.grade!))!)
        cell.countLabel.text = "리뷰 수 : \(self.designerModelArray[indexPath.row].review!.count!)"
        cell.nameLabel.text = self.designerModelArray[indexPath.row].name
        let openTime = "\(self.designerModelArray[indexPath.row].startTime!) ~ \(self.designerModelArray[indexPath.row].endTime!)"
        cell.openTimeLabel.text = openTime
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = (UIStoryboard (name: "designer", bundle: nil).instantiateViewControllerWithIdentifier("HTDesignerDetailVC")) as! HTDesignerDetailVC
        detailVC.id = self.designerModelArray[indexPath.row].id
        detailVC.name = self.designerModelArray[indexPath.row].name
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}