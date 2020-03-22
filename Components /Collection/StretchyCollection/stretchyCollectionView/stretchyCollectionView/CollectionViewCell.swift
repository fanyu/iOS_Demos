//
//  CollectionViewCell.swift
//  
//
//  Created by FanYu on 9/5/15.
//
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeAndRome: UILabel!
    
    var session: Session? {
        didSet {
            if let session = session {
                title.text = session.title
                timeAndRome.text = session.roomAndTime
            }
        }
    }
}
