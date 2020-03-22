//
//  TabBarViewController.swift
//  tabbartest
//
//  Created by FanYu on 20/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var midVC = MidViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.tabBar.backgroundColor = UIColor.blackColor()
        //self.tabBar.tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print(item.title!)
        
        item.selectedImage = UIImage(named: "publish")
        
        //tabBar.addSubview(img)
    }

}
