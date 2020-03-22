//
//  Header.swift
//  
//
//  Created by FanYu on 9/8/15.
//
//

import UIKit

class HeaderView: UICollectionReusableView {
   
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timelapse: Int? {
        didSet {
            if let time = timelapse {
                timeLabel.text = "\(time) m"
            }
        }
    }
    
    var album: Album? {
        didSet {
            if let album = album {
                headerLabel.text = album.title
            }
        }
    }
}
