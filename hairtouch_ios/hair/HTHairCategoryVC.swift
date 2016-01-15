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

class HTHairCategoryVC: HTViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        return cell
    }
    
    
    
    
    // action
    //
    //
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func findCategoryAction(sender: AnyObject) {
        
    }
}