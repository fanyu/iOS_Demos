//
//  CellView.swift
//  
//
//  Created by FanYu on 9/8/15.
//
//

import UIKit

class CellView: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likedButton: UIButton!
    @IBOutlet weak var likes: UILabel!

    var likesNum: Int? {
        didSet {
            if let num = likesNum {
                likes.text = "\(num) likes"
            }
        }
    }
    
    var liked = false
    @IBAction func likedButton(sender: AnyObject) {
        var num = likesNum!
        
        if !liked {
            sender.setImage(UIImage(named: "Like Filled"), forState: UIControlState.Normal)
            liked = true
            num = 1 + num
            
        } else {
            sender.setImage(UIImage(named: "Like"), forState: UIControlState.Normal)
            liked = false
            //num = num - 1
        }
        likes.text = "\(num) likes"
    }
    
    var photo: UIImage? {
        didSet {
            if let photo = photo {
                cellImage.image = photo
            }
        }
    }
}
