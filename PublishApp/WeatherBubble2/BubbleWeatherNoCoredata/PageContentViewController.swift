//
//  PageContentViewController.swift
//  
//
//  Created by FanYu on 7/28/15.
//
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    
    var pageIndex: Int?
    var pageCityAmount: Int?
    var pageCityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cityName.text = self.pageCityName
        self.view.backgroundColor = UIColor(red: 18.0 / 255.0, green: 18.0 / 255.0, blue: 18.0 / 255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
