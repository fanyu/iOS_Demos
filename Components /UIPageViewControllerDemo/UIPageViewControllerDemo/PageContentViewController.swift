//
//  ContentViewController.swift
//  
//
//  Created by FanYu on 7/13/15.
//
//

import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int?
    var imagePath: String?
    var titleText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageImage.image = UIImage(named: self.imagePath!)
        //view.backgroundColor = UIColor(patternImage: UIImage(named: imagePath!)!)
        self.titleLabel.text = self.titleText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
