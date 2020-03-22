//
//  DetailViewController.swift
//  
//
//  Created by FanYu on 8/25/15.
//
//

import UIKit

class DetailViewController: UIViewController {

    var detailName: String?
    var detailImage: UIImage?
    
    @IBOutlet weak var backGround: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var blog: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        name.text = detailName        
        image.image = detailImage//UIImage(named: cellImageData[])
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
