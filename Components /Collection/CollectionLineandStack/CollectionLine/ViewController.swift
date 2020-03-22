//
//  ViewController.swift
//  CollectionLine
//
//  Created by FanYu on 20/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var imageArray: [String] = {
        var array: [String] = []
        for i in 1 ... 20 {
            array.append("\(i)-1")
        }
        return array
    }()
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        // collection view
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 200), collectionViewLayout: StackLayout())
        collectionView!.backgroundColor = UIColor.whiteColor()
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        // register cell
        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        // add subview
        self.view.addSubview(collectionView!)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if self.collectionView!.collectionViewLayout.isKindOfClass(LineLayout.self) {
            self.collectionView!.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        }else {
            self.collectionView!.setCollectionViewLayout(LineLayout(), animated: true)
        }
        
    }

}



extension ViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.imageArray.removeAtIndex(indexPath.item)
        collectionView.deleteItemsAtIndexPaths([indexPath])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.imageStr = self.imageArray[indexPath.item]
        
        return cell
    }
}
