//
//  HTDesignerDetailVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 18..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HTDesignerDetailVC: HTViewController, UITableViewDelegate, UITableViewDataSource {
    
    var id: Int?
    var name: String?
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var designerInfoView: UIView!
    @IBOutlet weak var hairTableView: UITableView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    var designerModelArray = [HTDesignerModel]()
    
    override func viewDidLoad() {
        self.titleLabel.text = self.name
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HairCell") as! HTHairTableViewCell
        
        return cell
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func designerInfoAction(sender: AnyObject) {
        self.designerInfoView.hidden = false
        self.hairTableView.hidden = true
    }
    
    @IBAction func hairInfoAction(sender: AnyObject) {
        self.designerInfoView.hidden = true
        self.hairTableView.hidden = false
    }
    
}