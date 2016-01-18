//
//  HTHairCategoryVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 15..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

@objc public protocol HTHairCategoryDelegate {
    func findedCategoryCodeId(categoryCodeId: Int, categoryName: String)
}

class HTHairCategoryVC: HTViewController, UITableViewDelegate, UITableViewDataSource, HTHairCategoryDelegate {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var categoryTableView: UITableView!
    var categoryModelArray = [HTHairCategoryModel]()
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryModelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell") as! HTHairCategoryTableViewCell
        
        cell.nameLabel.text = self.categoryModelArray[indexPath.row].name
        
        return cell
    }
    
    
    // HTHairCategoryDelegate
    func findedCategoryCodeId(categoryCodeId: Int, categoryName: String) {
        self.categoryModelArray.removeAll()
        
        let parameters = ["code": categoryCodeId]
        
        Alamofire.request(.GET, "http://10.10.0.162:3000/haircategorys.json", parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let categorys = JSON as? NSArray {
                        for category in categorys {
                            if let dictionary = category as? NSDictionary {
                                let category_model = HTHairCategoryModel()
                                category_model.id = dictionary["id"] as? Int
                                category_model.name = (dictionary["name"] as? String)?.stringByReplacingOccurrencesOfString(",", withString: ">")
                                
                                self.categoryModelArray.append(category_model)
                            }
                        }
                    }
                }
                self.categoryNameLabel.text = categoryName
                self.categoryTableView.reloadData()
        }
    }
    
    // action
    //
    //
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func findCategoryAction(sender: AnyObject) {
        let detailVC = (UIStoryboard(name: "hair", bundle: nil).instantiateViewControllerWithIdentifier("HTHairCategoryDetailVC")) as! HTHairCategoryDetailVC
        detailVC.categoryVCDelegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}