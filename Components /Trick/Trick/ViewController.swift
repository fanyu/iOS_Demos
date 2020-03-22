//
//  ViewController.swift
//  Trick
//
//  Created by FanYu on 26/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        let image = UIImage(asset: .Apple)
    }
}


extension UIImage {
    
    convenience init(asset: ImageAsset) {
        self.init(named: asset.rawValue)!
    }
    
    enum ImageAsset: String {
        case Apple = "Apple"
        case Banana = "Banana"
        case Orange = "Orange"
    }
}
