//
//  MidViewController.swift
//  tabbartest
//
//  Created by FanYu on 20/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class MidViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        self.tabBarItem.title = "publish"
        selfDefineButoon()
        //self.tabBarController?.tabBar.tintColor = UIColor.grayColor()
        //self.tabBarController!.tabBar.selectedImageTintColor = UIColor.lightTextColor()
    }
    
    func selfDefineButoon() {
        let width = self.tabBarController!.tabBar.bounds.size.width
        let height = self.tabBarController!.tabBar.bounds.size.height
        let buttonWidth: CGFloat = 60
        let buttonHeight: CGFloat = 60
        
        let img = UIImageView(frame:CGRect (x: width / 2 - 4, y: -30, width: buttonWidth, height: buttonHeight))
        img.image = UIImage(named: "publish")
        self.tabBarController?.tabBar.addSubview(img)
        self.tabBarController?.tabBar.bringSubviewToFront(img)
        
        // remove the upper line
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        // add lines 
        let leftLineView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        leftLineView.backgroundColor = UIColor.lightGrayColor()
        
        
        self.tabBarController!.tabBar.addSubview(leftLineView)
        
        
            }
}
