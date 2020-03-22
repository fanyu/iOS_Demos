//
//  ViewController.swift
//  Godness
//
//  Created by FanYu on 1/3/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var BeatyName: UIPickerView!
    
    let beauties = ["范冰冰","李冰冰","王菲","杨幂","周迅"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BeatyName.delegate = self
        BeatyName.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "GoToGallery"
        {
            let index = BeatyName.selectedRowInComponent(0)
            var imageName:String?
            switch index
            {
            case 0 : imageName = "fangbingbing"
            case 1 : imageName = "libingbing"
            case 2 : imageName = "wangfei"
            case 3 : imageName = "yangmi"
            case 4 : imageName = "zhouxu"
            default :imageName = nil
            }
            
            var vc = segue.destinationViewController as! GalleryViewController
            vc.imageName = imageName
        }
    }
    
    //UnWind Segue
    @IBAction func close(segue:UIStoryboardSegue)
    {
        print("closed")
    }

}



class BubbleButton: UIButton {
    
    @IBInspectable var cornerRadius = 1
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.frame = CGRect(x: 80, y: 100, width: 200, height: 200)
        self.layer.cornerRadius = 45
        //self.layer.backgroundColor = UIColor.purpleColor().CGColor
        self.layer.borderWidth = 1
        //self.titleLabel?.text = "Hello World"
        //self.backgroundColor = UIColor.purpleColor()
        self.tintColor = UIColor.whiteColor()
        //self.setTitle(title: String?, forState: UIControlState)
        //self.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 1)
        //self.titleLabel?.numberOfLines = 2
        self.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.titleLabel?.textAlignment = NSTextAlignment.Center
        //self.titleLabel?.font = UIFont.systemFontOfSize(20)
    }
    
}
