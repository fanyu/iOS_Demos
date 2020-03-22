//
//  Album.swift
//  StickyHeaderDemo
//
//  Created by FanYu on 9/8/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class Album {
    var title: String
    var photos: [UIImage]
    
    init(title: String, photos: [UIImage]) {
        self.title = title
        self.photos = photos
    }
    
    class func allAlbums() ->[Album] {
        let titles = ["Allen", "Boob", "Channel", "David","Ellen","Fan","Yello","Water","edceezz","hello world","WhatThe","hhhhhh"]
        
        var backgroundImage = [UIImage]()
        for i in 1...12 {
            let imageName = String(format: "img-%02d", i)
            if let image = UIImage(named: imageName) {
                backgroundImage.append(image.decompressedImage)
            }
        }
        
        var albums = [Album]()
        var offset = 0
        for title in titles {
            //let photos = Array(backgroundImage[offset..<offset + 2])
            let photos = Array(arrayLiteral: backgroundImage[offset])
            let album = Album(title: title, photos: photos)
            albums.append(album)
            offset += 1
        }
        return albums
    }
}

extension UIImage {
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        drawAtPoint(CGPointZero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage
    }
}