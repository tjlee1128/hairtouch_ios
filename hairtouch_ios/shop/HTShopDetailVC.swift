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
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    var shopDetailDictionary = [String: AnyObject]()
    var designerArray = [[String: AnyObject]]()
    
    var designerModelArray = [HTDesignerModel]()
    
    override func viewDidLoad() {
        // set title
        self.titleLabel.text = self.name
        
        // set image
        self.imageScrollView.frame = CGRectMake(self.imageScrollView.frame.origin.x, self.imageScrollView.frame.origin.y, self.view.frame.width, 200)
        let scrollViewHeight = self.imageScrollView.frame.height
        let scrollViewWidth = self.imageScrollView.frame.width
        
        let imageOne = UIImageView(frame: CGRectMake(0, 0, scrollViewWidth, scrollViewHeight))
        let imageTwo = UIImageView(frame: CGRectMake(scrollViewWidth, 0, scrollViewWidth, scrollViewHeight))
        let imageThree = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0, scrollViewWidth, scrollViewHeight))
        
        imageOne.image = UIImage(named: "shop_image1")
        imageTwo.image = UIImage(named: "shop_image2")
        imageThree.image = UIImage(named: "shop_image3")
        
        self.imageScrollView.addSubview(imageOne)
        self.imageScrollView.addSubview(imageTwo)
        self.imageScrollView.addSubview(imageThree)
        
        self.imageScrollView.contentSize = CGSizeMake(self.imageScrollView.frame.width*3, self.imageScrollView.frame.height)
        
        // set table
        Alamofire.request(.GET, "http://hairtouch.dev/shops/\(self.shopId! as Int).json", parameters: nil)
            .responseJSON { response in
                self.shopDetailDictionary = response.result.value as! Dictionary
                self.designerArray = self.shopDetailDictionary["designers"] as! Array
                
                if let JSON = response.result.value {
                    if let designers = JSON["designers"] as? NSArray {
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
    
    //
    //
    // tableview
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