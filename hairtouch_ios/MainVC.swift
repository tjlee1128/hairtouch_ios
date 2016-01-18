//
//  MainVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 12..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

@objc public protocol MainDelegate {
    optional func refreshData()
}

class MainVC: HTViewController, MainDelegate {
    
    var mainRegionArray = [HTMainRegionModel]()
    var subRegionArray = [HTSubRegionModel]()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
        
        Alamofire.request(.GET, "http://10.10.0.162:3000/regions.json", parameters: nil)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let mainRegionJSON = JSON["mainregion"] as? NSArray {
                        for mainRegion in mainRegionJSON {
                            if let dictionary = mainRegion as? NSDictionary {
                                let mainRegionModel = HTMainRegionModel()
                                mainRegionModel.id = dictionary["id"] as? Int
                                mainRegionModel.name = dictionary["name"] as? String
                                
                                self.mainRegionArray.append(mainRegionModel)
                            }
                        }
                    }
                    
                    if let subRegionJSON = JSON["subregion"] as? NSArray {
                        for subRegion in subRegionJSON {
                            if let dictionary = subRegion as? NSDictionary {
                                let subRegionModel = HTSubRegionModel()
                                subRegionModel.id = dictionary["id"] as? Int
                                subRegionModel.name = dictionary["name"] as? String
                                subRegionModel.mainRegionId = dictionary["mainregion_id"] as? Int
                                
                                self.subRegionArray.append(subRegionModel)
                            }
                        }
                    }
                }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    func refreshData() {
        print("MainVC refreshData()!!!")
    }
    
    @IBAction func findRegionAction(sender: AnyObject) {
        let regionVC = (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HTRegionVC")) as! HTRegionVC
        regionVC.delegate = self
        self.navigationController?.pushViewController(regionVC, animated: true)
    }
    
    @IBAction func storeAction(sender: AnyObject) {
        let shopVC = (UIStoryboard(name: "shop", bundle: nil).instantiateViewControllerWithIdentifier("HTShopVC"))
        self.navigationController?.pushViewController(shopVC, animated: true)
    }
    
    @IBAction func designerAction(sender: AnyObject) {
        let designerVC = (UIStoryboard(name: "designer", bundle: nil).instantiateViewControllerWithIdentifier("HTDesignerVC"))
        self.navigationController?.pushViewController(designerVC, animated: true)
    }
    
    @IBAction func procedureAction(sender: AnyObject) {
        let haircategoryVC = (UIStoryboard(name: "hair", bundle: nil).instantiateViewControllerWithIdentifier("HTHairCategoryVC"))
        self.navigationController?.pushViewController(haircategoryVC, animated: true)
    }
    
    @IBAction func mypageAction(sender: AnyObject) {
    }
    
}