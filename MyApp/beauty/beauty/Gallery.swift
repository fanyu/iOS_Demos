//
//  Gallery.swift
//  beauty
//
//  Created by FanYu on 1/6/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit
import Social

class Gallery: UIViewController
{
    
    @IBOutlet weak var BeautyPic: UIImageView!
    var imageName:String?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let name = imageName
        {
            BeautyPic.image = UIImage(named:name)
            switch name
            {
            case "fangbingbing" : navigationItem.title = "范冰冰"
            case "LiBingBing" : navigationItem.title = "李冰冰"
            default : navigationItem.title = "No"
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareHitted(sender: AnyObject)
    {
        var share:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        share.setInitialText("hello world")
        share.addImage(BeautyPic.image)
    }
}