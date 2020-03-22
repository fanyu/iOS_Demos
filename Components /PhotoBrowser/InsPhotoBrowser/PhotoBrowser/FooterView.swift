//
//  LoadingCollectionView.swift
//  PhotoBrowser
//
//  Created by FanYu on 21/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit


// Footer View
class FooterView: UICollectionReusableView {
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        spinner.startAnimating()
        spinner.center = self.center
        addSubview(spinner)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


