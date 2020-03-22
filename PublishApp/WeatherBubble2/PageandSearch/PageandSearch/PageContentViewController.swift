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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
