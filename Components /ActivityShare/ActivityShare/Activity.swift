//
//  Activity.swift
//  ActivityShare
//
//  Created by FanYu on 3/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

public class Activity: UIActivity {
    
    private let type: String
    private let title: String
    private let image: UIImage

    public init(type: String, title: String, image: UIImage) {
        
        self.type = type
        self.title = title
        self.image = image
        
        super.init()
    }
    
    override public class func activityCategory() -> UIActivityCategory {
        return .Share
    }
    
    override public func activityType() -> String? {
        return type
    }
    
    override public func activityTitle() -> String? {
        return title
    }
    
    override public func activityImage() -> UIImage? {
        return image
    }
    
    override public func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        return true
    }
    
//    override public func prepareWithActivityItems(activityItems: [AnyObject]) {
//        
//    }
//    
//    override public func activityViewController() -> UIViewController? {
//        
//    }
    
    override public func performActivity() {
        activityDidFinish(true)
    }

}
