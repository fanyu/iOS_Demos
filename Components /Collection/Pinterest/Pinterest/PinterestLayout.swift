//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by FanYu on 23/11/2015.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
  // photo
  func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) ->CGFloat
  // annotation
  func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) ->CGFloat
}


// By subclassing UICollectionViewLayoutAttributes, you can add your own properties, which are automatically passed to the cell
class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
  
  // photoHeight property that the cell will use to resize its image view.
  var photoHeight: CGFloat = 0

  override func copyWithZone(zone: NSZone) -> AnyObject {
    
    let copy = super.copyWithZone(zone) as! PinterestLayoutAttributes
    copy.photoHeight = photoHeight
    
    return copy
  }
  
  override func isEqual(object: AnyObject?) -> Bool {
    
    if let attributes = object as? PinterestLayoutAttributes {
      if attributes.photoHeight == photoHeight {
        return super.isEqual(object)
      }
    }
    
    return false
  }
  
}


class PinterestLayout: UICollectionViewLayout {
  
  var delegate: PinterestLayoutDelegate!
  
  let numberOfColumns = 2
  let cellPadding: CGFloat = 6.0
  
  private var cache = [PinterestLayoutAttributes]()
  
  private var contentHeight: CGFloat = 0
  private var contentWidth: CGFloat {
    let insets = collectionView!.contentInset
    return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
  }
  
  
  //  tell the collection view to use PinterestLayoutAttributes whenever it creates layout attributes objects.
  override class func layoutAttributesClass() -> AnyClass {
    return PinterestLayoutAttributes.self
  }
  
  override func prepareLayout() {
    if cache.isEmpty {
      
      // x offset
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset = [CGFloat]()
      for column in 0 ..< numberOfColumns {
        xOffset.append(CGFloat(column) * columnWidth)
      }
      
      // y offset
      var column = 0
      var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
      
      // attributes setting
      for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
        // indexPath
        let indexPath = NSIndexPath(forItem: item, inSection: 0)
        
        // width
        let width = columnWidth - cellPadding * 2
        
        // height
        let photoHeight      = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
        let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
        let height           = cellPadding + photoHeight + annotationHeight + cellPadding
        
        // frame
        let frame      = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
        
        // attribute frame
        let attributes   = PinterestLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.photoHeight = photoHeight
        attributes.frame = insetFrame
        
        cache.append(attributes)
        
        // chage height which used for calculate contentsize
        self.contentHeight = max(contentHeight, CGRectGetMaxY(frame))
        
        // change yOffset
        yOffset[column] = yOffset[column] + height
        
        // change colum
        column = column >= (numberOfColumns - 1) ? 0 : ++column
      }
    }
  }
  
  // content size
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  
  // rect
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var attributes = [UICollectionViewLayoutAttributes]()
    
    for attribute in cache {
      if CGRectIntersectsRect(attribute.frame, rect) {
        attributes.append(attribute)
      }
    }
    
    return attributes
  }
}
