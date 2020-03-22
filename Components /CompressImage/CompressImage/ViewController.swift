//
//  ViewController.swift
//  CompressImage
//
//  Created by FanYu on 3/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "1")
        let imageV = UIImageView(image: image)
        imageV.frame.origin = CGPointMake(0, 0)
        self.view.addSubview(imageV)
        print("OriginImage \(image?.size)")
        
        
        let newImage = EDCCompressImage().compressImageSize(UIImage(named: "1")!, newSize: CGSizeMake(50, 50))
        let imageV2 = UIImageView(image: newImage)
        imageV2.frame.origin = CGPointMake(20, 300)
        self.view.addSubview(imageV2)
        print(newImage.size)
        
        let new4 = EDCCompressImage().compressImageQuality(image!, percent: 0.5)
        print("\(new4.size)")
        
        
        let new3 = EDCCompressImage().resetImageData(image!, maxSize: 1)
        let imageV3 = UIImageView(image: new3)
        imageV3.frame.origin = CGPointMake(40, 400)
        self.view.addSubview(imageV3)
        print(new3.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




