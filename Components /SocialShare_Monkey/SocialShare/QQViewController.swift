//
//  QQViewController.swift
//  SocialShare
//
//  Created by FanYu on 3/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import MonkeyKing

class QQViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let account = MonkeyKing.Account.QQ(appID: Configs.QQ.appID)
        MonkeyKing.registerAccount(account)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func shareText(sender: UIButton) {
        let info = MonkeyKing.Info(
            title: nil,
            description: "QQ Text: Hello World, \(NSUUID().UUIDString)",
            thumbnail: nil,
            media: nil
        )
        
        shareInfo(info)
    }
    
    @IBAction func shareURL(sender: UIButton) {
        let info = MonkeyKing.Info(
            title: "QQ URL, \(NSUUID().UUIDString)",
            description: "apple.com/cn, \(NSUUID().UUIDString)",
            thumbnail: UIImage(named: "rabbit")!,
            media: .URL(NSURL(string: "http://www.apple.com/cn")!)
        )
        
        shareInfo(info)
    }
    
    @IBAction func shareImage(sender: UIButton) {
        let info = MonkeyKing.Info(
            title: "QQ Image, \(NSUUID().UUIDString)",
            description: "Hello World, \(NSUUID().UUIDString)",
            thumbnail: nil,
            media: .Image(UIImage(named: "rabbit")!)
        )
        
        shareInfo(info)
    }
    
    @IBAction func shareAudio(sender: UIButton) {
        let info = MonkeyKing.Info(
            title: "QQ Audio, \(NSUUID().UUIDString)",
            description: "Hello World, \(NSUUID().UUIDString)",
            thumbnail: UIImage(named: "rabbit")!,
            media: .Audio(audioURL: NSURL(string: "http://wfmusic.3g.qq.com/s?g_f=0&fr=&aid=mu_detail&id=2511915")!, linkURL: nil)
        )
        
        shareInfo(info)
    }
    
    @IBAction func shareVideo(sender: UIButton) {
        let info = MonkeyKing.Info(
            title: "QQ Video, \(NSUUID().UUIDString)",
            description: "Hello World, \(NSUUID().UUIDString)",
            thumbnail: UIImage(named: "rabbit")!,
            media: .Video(NSURL(string: "http://v.youku.com/v_show/id_XOTU2MzA0NzY4.html")!)
        )
        
        shareInfo(info)
    }
    
    
    @IBAction func shareFile(sender: UIButton) {
        let info = MonkeyKing.Info(
            title: "Dataline File, \(NSUUID().UUIDString)",
            description: "pay.php",
            thumbnail: nil,
            media: .File(NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("pay", ofType: "php")!)!)
        )
        
        shareInfo(info)
    }
    
    private func shareInfo(info: MonkeyKing.Info) {
        
        var message :MonkeyKing.Message?
        
        switch self.segmentControl.selectedSegmentIndex{
        case 0:
            message = MonkeyKing.Message.QQ(.Friends(info: info))
        case 1:
            message = MonkeyKing.Message.QQ(.Zone(info: info))
        case 2:
            message = MonkeyKing.Message.QQ(.Dataline(info: info))
        case 3:
            message = MonkeyKing.Message.QQ(.Favorites(info: info))
        default:()
        }
        
        if let message = message{
            MonkeyKing.shareMessage(message) { result in
                print("result: \(result)")
            }
        }
    }

    
    @IBAction func OAuth(sender: UIButton) {
        MonkeyKing.OAuth(.QQ, scope: "get_user_info") { (OAuthInfo, response, error) -> Void in
            
            guard let token = OAuthInfo?["access_token"] as? String,
                let openID = OAuthInfo?["openid"] as? String else {
                    return
            }
            
            let query = "get_user_info"
            let userInfoAPI = "https://graph.qq.com/user/\(query)"
            
            let parameters = [
                "openid": openID,
                "access_token": token,
                "oauth_consumer_key": Configs.QQ.appID
            ]
            
            // fetch UserInfo by userInfoAPI
            SimpleNetworking.sharedInstance.request(userInfoAPI, method: .GET, parameters: parameters, completionHandler: { (userInfoDictionary, _, _) -> Void in
                print("userInfoDictionary \(userInfoDictionary)")
            })
        }
    }
}
