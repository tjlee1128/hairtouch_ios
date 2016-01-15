//
//  HTHairCategoryDetailVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 15..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HTHairCategoryDetailVC: HTViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categoryModelArray = [HTHairCategoryModel]()
    var categoryVCDelegate: HTHairCategoryDelegate?
    var categoryCodeId: Int?
    var categoryName: String?
    
    override func viewDidLoad() {
        
        Alamofire.request(.GET, "http://hairtouch.dev/haircategorycodes.json", parameters: nil)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let category_codes = JSON as? NSArray {
                        for category_gode in category_codes {
                            if let dictionary = category_gode as? NSDictionary {
                                let category_code_model = HTHairCategoryModel()
                                category_code_model.id = dictionary["id"] as? Int
                                category_code_model.name = (dictionary["name"] as? String)?.stringByReplacingOccurrencesOfString(",", withString: ">")
                                
                                self.categoryModelArray.append(category_code_model)
                            }
                        }
                    }
                }
                self.categoryTableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell") as! HTHairCategoryTableViewCell
        
        cell.nameLabel.text = self.categoryModelArray[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.categoryCodeId = self.categoryModelArray[indexPath.row].id
        self.categoryName = self.categoryModelArray[indexPath.row].name
        self.completeButton.enabled = true
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func completeAction(sender: AnyObject) {
        self.categoryVCDelegate?.findedCategoryCodeId(self.categoryCodeId!, categoryName: self.categoryName!)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}