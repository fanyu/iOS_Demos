//
//  EDCSearchBar.swift
//  SearchController
//
//  Created by FanYu on 30/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class EDCSearchBar: UISearchBar {
    
    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    
    init(frame: CGRect, font: UIFont, textColor:UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        self.preferredFont = font
        self.preferredTextColor = textColor
        
        self.searchBarStyle = UISearchBarStyle.Prominent
        self.translucent = false
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // get the index of the search field in the search bar subviews
    func indexOfSearchFieldInSubviews() ->Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0 ... searchBarView.subviews.count {
            if searchBarView.subviews[i].isKindOfClass(UITextField) {
                index = i
                break
            }
        }
    
        print("subviews\(subviews) \n count:\(subviews.count)")
        print(subviews[0].subviews.count)
        print(subviews[0].subviews)
        return index
    }
    
    override func drawRect(rect: CGRect) {

        if let index = indexOfSearchFieldInSubviews() {
            // access the search field 
            let searchField: UITextField = subviews[0].subviews[index] as! UITextField
            
            // frame
            searchField.frame = CGRect(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10)
            // font and color 
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            // background 
            searchField.backgroundColor = barTintColor
        }
        
        // bottom line
        let startPoint = CGPointMake(0.0, frame.size.height)
        let endPoint = CGPointMake(frame.size.width, frame.size.height)
        let path = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = preferredTextColor.CGColor
        shapeLayer.lineWidth = 2.5
        
        layer.addSublayer(shapeLayer)
        
        super.drawRect(rect)
    }
}
