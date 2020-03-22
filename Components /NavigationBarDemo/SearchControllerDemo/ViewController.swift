//
//  ViewController.swift
//  SearchControllerDemo
//
//  Created by FanYu on 27/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navi Bar
        // bar background set as image
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "pc"), forBarMetrics: .Default)
        // bar translucent 
        self.navigationController?.navigationBar.translucent = false
        // bar color
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        // bar style
        self.navigationController?.navigationBar.barStyle = .Default
        // bar button color
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        // MARK: - Title
        // set title
        self.navigationItem.title = "Hello"
        // title Font
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)!]
        // title color and alpha
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)]
        // image as title
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "titleImage"))
        // title Shadow
        var shadow: NSShadow {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.blackColor().CGColor
            shadow.shadowOffset = CGSize(width: 0, height: 1)
            return shadow
        }
        self.navigationController?.navigationBar.titleTextAttributes = [ NSShadowAttributeName : shadow]
        
        // MARK: - Back Button
        // back title
        let backButton = UIBarButtonItem(title: "World", style: .Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        // back chevron
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow")
        
        // MARK: - Add Bar Button
        let buttonOne = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: nil)
        let buttonTwo = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: nil)
        let buttons: NSArray = [buttonOne, buttonTwo]
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        
        // MARK: - Hairline and Effect View(blur View)
        // hide hairline and effect view (hide hairline must use both of them)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

