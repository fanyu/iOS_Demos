//
//  ViewController.swift
//  PhotoFromSystem
//
//  Created by FanYu on 19/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var photoPickerVC = TakePhotoViewController()
    var fetchVC = FectchPhotosViewController()
    var collectionVC = FetchCollectionViewController()
    var allPhotosTV = AllPhotoListViewController()
    
    @IBAction func takePhotoDemo(sender: UIButton) {
        self.navigationController?.pushViewController(photoPickerVC, animated: true)
    }
    
    @IBAction func fetchPhotoDemo(sender: UIButton) {
        self.navigationController?.pushViewController(fetchVC, animated: true)
    }
    
    @IBAction func Collection(sender: UIButton) {
        self.navigationController?.pushViewController(collectionVC, animated: true)
    }
    
    @IBAction func allPhotosDemo(sender: UIButton) {
        self.navigationController?.pushViewController(allPhotosTV, animated: true)
    }
    
    @IBAction func customerTakePhoto(sender: UIButton) {
        let customerPhotoVC = CustomerTakePhotoViewController()
        self.navigationController?.pushViewController(customerPhotoVC, animated: true)
    }
    
    @IBAction func yepStyleDemo(sender: UIButton) {
        let yepVC = YepChooseImageViewController()
        self.navigationController?.pushViewController(yepVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

