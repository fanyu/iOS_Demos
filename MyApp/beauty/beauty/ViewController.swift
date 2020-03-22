//
//  ViewController.swift
//  beauty
//
//  Created by FanYu on 1/6/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BeautyName: UIPickerView!
    
    let Beauties:[String] = ["FanBingBing","LiBingBing","WangFei"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BeautyName.delegate = self
        BeautyName.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "GotoGallery"
        {
            let index = BeautyName.selectedRowInComponent(0)
            var pic:String?
            switch index
            {
            case 0 : pic = "fangbingbing"
            case 1 : pic = "libingbing"
            case 2 : pic = "WangFei"
            default : pic = "No"
            }
            
            var vc = segue.destinationViewController as! Gallery
            vc.imageName = pic
        }
    }
    
    //UnWind Segue
    @IBAction func close(segue:UIStoryboardSegue)
    {
        print("closed")
    }

}

