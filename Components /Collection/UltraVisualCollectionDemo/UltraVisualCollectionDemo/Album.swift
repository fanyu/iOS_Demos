//
//  Album.swift
//  UltraVisualCollectionDemo
//
//  Created by FanYu on 9/11/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class Album {
    
    //var photos:[UIImage]
    
    class func allPhotos() ->[UIImage] {
        var photos = [UIImage]()
        
        for i in 1 ... 12 {
            let imageName = String(format: "img-%02d", i)
            let image = UIImage(named: imageName)
            photos.append(image!.decompressedImage)
        }
        return photos
    }

}
