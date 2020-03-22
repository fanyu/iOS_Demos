//
//  TakePhotoViewController.swift
//  PhotoFromSystem
//
//  Created by FanYu on 19/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class TakePhotoViewController: UIViewController {

    private var width: CGFloat { return UIScreen.mainScreen().bounds.width }
    private var height: CGFloat { return UIScreen.mainScreen().bounds.height }
    
    private var takePhotoButton: UIButton!
    private var imageContent: UIImageView!
    
    private var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setup() {
        // self 
        self.view.backgroundColor = UIColor.whiteColor()
        
        // image view 
        let center = self.view.center
        imageContent = UIImageView(frame: CGRect(x: 0, y: 100, width: 200, height: 200))
        imageContent.center.x = center.x
        imageContent.backgroundColor = UIColor.redColor()
        view.addSubview(imageContent)
        
        // button 
        takePhotoButton = UIButton(frame: CGRect(x: 0, y: 400, width: 150, height: 22))
        takePhotoButton.center.x = center.x
        takePhotoButton.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
        takePhotoButton.setTitle("Choose Photo", forState: .Normal)
        takePhotoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        takePhotoButton.titleLabel?.textAlignment = .Center
        takePhotoButton.addTarget(self, action: #selector(TakePhotoViewController.choosePhoto), forControlEvents: .TouchUpInside)
        view.addSubview(takePhotoButton)
        
        
        // image picker 
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary//.Camera
    }
}


// MARK: - Image Picker Delegate 
extension TakePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageContent.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("Did Cancle")
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }

}


// MARK: - Handler
extension TakePhotoViewController {
    func choosePhoto() {
        print("Choose Photo")
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}


