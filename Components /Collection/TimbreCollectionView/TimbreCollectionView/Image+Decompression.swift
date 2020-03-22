//
//  Image+Decompression.swift
//  UltraVisualCollectionDemo
//
//  Created by FanYu on 9/10/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

extension UIImage {
    
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        drawAtPoint(CGPointZero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage
    }
}

