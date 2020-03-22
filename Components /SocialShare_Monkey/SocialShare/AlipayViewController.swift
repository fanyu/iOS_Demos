//
//  AlipayViewController.swift
//  SocialShare
//
//  Created by FanYu on 3/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import MonkeyKing

class AlipayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let account = MonkeyKing.Account.Alipay(appID: Configs.Alipay.appID)
        MonkeyKing.registerAccount(account)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareText(sender: UIButton) {
        let info =  MonkeyKing.Info(
            title: "Friends Text, \(NSUUID().UUIDString)",
            description: nil,
            thumbnail: nil,
            media: nil
        )
        self.shareInfo(info)
    }
    
    @IBAction func shareImage(sender: UIButton) {
        let info =  MonkeyKing.Info(
            title: nil,
            description: nil,
            thumbnail: nil,
            media: .Image(UIImage(named: "rabbit")!)
        )
        self.shareInfo(info)
    }
    
    @IBAction func shareURL(sender: UIButton) {
        let info =  MonkeyKing.Info(
            title: "Friends URL, \(NSUUID().UUIDString)",
            description: "Description URL, \(NSUUID().UUIDString)",
            thumbnail: UIImage(named: "rabbit"),
            media: .URL(NSURL(string: "http://soyep.com")!)
        )
        self.shareInfo(info)
    }
    
    @IBAction func pay(sender: UIButton) {
        do {
            let data = try NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: NSURL(string: "http://www.example.com/pay.php?payType=alipay")!), returningResponse: nil)
            let URLString = String(data: data, encoding: NSUTF8StringEncoding)
            
            let order = MonkeyKing.Order.Alipay(URLString: URLString!)
            
            MonkeyKing.payOrder(order) { result in
                print("result: \(result)")
            }
            
        } catch (let e) {
            print(e)
        }
    }
    
    private func shareInfo(info: MonkeyKing.Info) {
        let message = MonkeyKing.Message.Alipay(.Friends(info: info))
        MonkeyKing.shareMessage(message) { (result) -> Void in
            print("result: \(result)")
        }
    }
}
