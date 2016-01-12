//
//  HTShopVC.swift
//  hairtouch_ios
//
//  Created by lee taejun on 2016. 1. 12..
//  Copyright © 2016년 lee taejun. All rights reserved.
//

import Foundation
import UIKit

class HTShopVC: HTViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var shopTableView: UITableView!
    
    class Shop {
        var name: String
        var address: String
        
        init(name: String, address: String) {
            self.name = name
            self.address = address
        }
    }
    
    var shops = [Shop]()
    
    // life cycle
    override func viewDidLoad() {
        
        // test data
        let shop1 = Shop(name: "이태준 헤어", address: "경기도 부천시 원미구 심곡 1동 94-5")
        let shop2 = Shop(name: "용대 머리짱", address: "서울특별시 관악구 행운동 112")
        let shop3 = Shop(name: "태양 뷰티랩", address: "서울특별시 도봉구 쌍문동 신화로즈빌112")
        let shop4 = Shop(name: "여은 헤어드레서", address: "서울특별시 강남구 역삼동 보정빌딩 1123")
        let shop5 = Shop(name: "영일 헤어", address: "서울특별시 양천구 신월동 123")
        let shop6 = Shop(name: "승영 미용실", address: "경기도 부천시 원미구 중동 미리내마을 103-222222222222222222")
        let shop7 = Shop(name: "민국 헤어샵", address: "강원도 삼척시 봉포해수욕장 기와집")
        self.shops.append(shop1)
        self.shops.append(shop2)
        self.shops.append(shop3)
        self.shops.append(shop4)
        self.shops.append(shop5)
        self.shops.append(shop6)
        self.shops.append(shop7)
        
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    
    // UITableViewDataSource delegate functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if !self.shops.isEmpty {
            return 1
        } else {
            return 0
        }
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
        
        let shopInfo = self.shops[indexPath.row]
        cell.nameLabel.text = shopInfo.name
        cell.addressLabel.text = shopInfo.address
        
        return cell
    }
    
    
    // UITableViewDelegate delegate functions
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "shop", bundle: nil).instantiateViewControllerWithIdentifier("HTShopDetailVC") as! HTShopDetailVC
        let shopInfo = self.shops[indexPath.row]
        vc.name = shopInfo.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // action
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
