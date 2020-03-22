//
//  KoreanViewerController.swift
//  Godness
//
//  Created by FanYu on 1/5/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//


import UIKit
import Social
class KoreanViewController: UIViewController
{

    @IBOutlet weak var BeautyImage: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookHit(sender: AnyObject)
    {
        var controler:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        controler.setInitialText("test facebook, Edison")
        controler.addImage(BeautyImage.image)
        self.presentViewController(controler, animated: true, completion: nil)
    }
    
    @IBAction func twitterHit(sender: AnyObject)
    {
        var controler:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        controler.setInitialText("test facebook, Edison")
        controler.addImage(BeautyImage.image)
        self.presentViewController(controler, animated: true, completion: nil)
    }
    
    @IBAction func weiboHit(sender: AnyObject)
    {
        var controler:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
        controler.setInitialText("test facebook, Edison")
        controler.addImage(BeautyImage.image)
        self.presentViewController(controler, animated: true, completion: nil)
    }
    
}