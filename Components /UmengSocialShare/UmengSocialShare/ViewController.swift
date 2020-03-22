//
//  ViewController.swift
//  UmengSocialShare
//
//  Created by FanYu on 9/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UMSocialUIDelegate {

    
    @IBAction func shareButtonTapped(sender: UIButton) {
        
        UMSocialSnsService.presentSnsIconSheetView(self,
            appKey: "56df739e67e58ed6bd00384d",
            shareText: "Test",
            shareImage: nil,
            shareToSnsNames: [UMShareToSina,UMShareToWechatSession,UMShareToQQ],
            delegate: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        isDirectShareInIconActionSheet()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func isDirectShareInIconActionSheet() -> Bool {
        return true
    }
    
}

