//
//  EDCCompressImage.swift
//  CompressImage
//
//  Created by FanYu on 3/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit


// MARK: - 在内存中压缩 需要消耗内存，如果图片较多，可能会造成crash
class EDCCompressImage {
    
    func compressImageQuality(image: UIImage, percent: CGFloat) ->UIImage {
        let imageData: NSData = UIImageJPEGRepresentation(image, percent)!
        let newImage = UIImage(data: imageData)
        
        return newImage!
    }
    
    func compressImageSize(image: UIImage, newSize: CGSize) ->UIImage {
        // begin a graphic image context
        UIGraphicsBeginImageContext(newSize)
        // new size
        image.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        // get the iamge from context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // end graphic image context
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func resetImageData(image: UIImage, maxSize: Int) ->UIImage {
        
        // 先调整分辨率
        var newSize = CGSizeMake(image.size.width, image.size.height)
        let tempHeight = newSize.height / 1024
        let tempWidth = newSize.width / 1024
        
        if tempWidth > 1 && tempWidth > tempHeight {
            newSize = CGSizeMake(image.size.width / tempWidth, image.size.height / tempWidth)
        } else if tempHeight > 1 && tempHeight > tempWidth {
            newSize = CGSizeMake(image.size.width / tempHeight, image.size.height / tempHeight)
        }
        
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 再调整大小
        let imageData = UIImageJPEGRepresentation(newImage, 1.0)
        let sizeOrigin = imageData!.length
        let sizeOriginKB = sizeOrigin / 1024
        
        if sizeOriginKB > maxSize {
            let finalImageData = UIImageJPEGRepresentation(newImage, 0.5)
            return UIImage(data: finalImageData!)!
        }
        return UIImage(data: imageData!)!
    }
    
    func getImageSize(image: UIImage) ->Int {
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let imageKB = (imageData?.length)! / 1024
    
        return imageKB
    }
}
