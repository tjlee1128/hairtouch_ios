//
//  MainVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 12..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit

class MainVC: HTViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var testArray = [String]()
    
    override func viewDidLoad() {
        self.title = "hello world"
        
        testArray.append("매 장")
        testArray.append("디자이너")
        testArray.append("시 술")
        testArray.append("설 정")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("main_cell", forIndexPath: indexPath) as! MainCollectionViewCell
    
        cell.label.text = Array(testArray)[indexPath.row];
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let shopStoryboard = UIStoryboard(name: "shop", bundle: nil)
        let designerStoryboard = UIStoryboard(name: "designer", bundle: nil)
        var vc: UIViewController!
        if indexPath.row == 0 {
            vc = shopStoryboard.instantiateViewControllerWithIdentifier("HTShopVC")
        } else if indexPath.row == 1 {
            vc = designerStoryboard.instantiateViewControllerWithIdentifier("HTDesignerVC")
        } else if indexPath.row == 2 {
            vc = shopStoryboard.instantiateViewControllerWithIdentifier("HTShopVC")
        } else {
            vc = shopStoryboard.instantiateViewControllerWithIdentifier("HTShopVC")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}