//
//  Gallery.swift
//  Godness
//
//  Created by FanYu on 1/3/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit
import Social
class GalleryViewController: UIViewController {
    
    @IBOutlet weak var beautyImage: UIImageView!
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let name =  imageName
        {
            beautyImage.image = UIImage(named:name)
            switch name
            {
            case "fangbingbing" : navigationItem.title = "范冰冰"
            case "libingbing" : navigationItem.title = "李冰冰"
            case "wangfei" : navigationItem.title = "王菲"
            case "yangmi" : navigationItem.title = "杨幂"
            case "zhouxu" : navigationItem.title = "周迅"
            default : navigationItem.title = "女神"
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Share(sender: AnyObject)
    {
        var control:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        control.setInitialText("Hello, let's play GodnessGallery, it's really interesting!")
        control.addImage(beautyImage.image)
        self.presentViewController(control, animated: true, completion: nil)
    }
    
}