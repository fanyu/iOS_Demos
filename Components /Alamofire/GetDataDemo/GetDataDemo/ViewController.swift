//
//  ViewController.swift
//  GetDataDemo
//
//  Created by FanYu on 24/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import Alamofire

let CellIdentifier = "Cell"

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isLoadingMore = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(CollectionCell.self, forCellWithReuseIdentifier: CellIdentifier)
        
        
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    }


// Alamafire Get
//
extension ViewController {
    func getData() -> Void {
        
        Alamofire.request(.GET, "https://api.500px.com/v1/photos", parameters: ["consumer_key": API.key]).responseJSON() {
            response in
            guard let JSON = response.result.value else { return }
            
            guard let photoJsons = JSON.valueForKey("photos") as? [NSDictionary] else { return }
            
            photoJsons.forEach({ (NSDictionary) in
                guard let nsfw = NSDictionary["nsfw"] as? Bool,
                    let id = NSDictionary["id"] as? Int,
                    let url = NSDictionary["image_url"] as? String
                    where nsfw == false else { return }
                
            })
        }
    }

    
    func useRouter() -> Void {
        
        // 如果当前正在加载 则返回 不进行重复的加载
        if isLoadingMore {
            return
        }
        
        // 否则 开始进行加载
        isLoadingMore = true
        
        // Alamofire 请求本身就是异步的
        Alamofire.request(FYPhotos.Router.Comments(20, 20)).responseJSON() { response in
            func failed() {
                self.isLoadingMore = false
            }
            
            // 确保获取到JSON数据
            guard let JSON = response.result.value else {
                failed()
                return
            }
            
            // 确保没有错误
            if response.result.error != nil {
                failed()
                return
            }
            
            // 异步进行数据的解析
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                
                guard let photoJsons = JSON.valueForKey("photos") as? [NSDictionary] else { return }
            
                photoJsons.forEach({ (NSDictionary) in
                    guard let nsfw = NSDictionary["nsfw"] as? Bool,
                        let id = NSDictionary["id"] as? Int,
                        let url = NSDictionary["image_url"] as? String
                        where nsfw == false else { return }
                    
                    // 这里进行数据插入到数据库
                })
                
                // 异步主线程里面更新UI
                dispatch_async(dispatch_get_main_queue(), { 
                    self.collectionView.insertItemsAtIndexPaths([NSIndexPath(index: 1)])
                })
            })
        }
        
        // 加载结束
        isLoadingMore = false
    }
}


// MARK: Collection DataSource
// 
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as! CollectionCell
        
        // 当一个单元出列后，我们通过设值为nil的方法来清除图片。这个操作确保我们不会显示原先的图片
        let url = ""
        cell.imageView?.image = nil
        cell.request?.cancel()
    
        // 检查单元的 URL 是否和请求的 URL 相等。如果不相等的话，显然单元已经拥有了另外的图片，那么完成处理方法将不会浪费其生命周期来为单元设置错误的图片
        cell.request = Alamofire.request(.GET, url).responseImage() {
            response in
            
            guard let image = response.result.value where response.result.error == nil else { return }
            
            cell.imageView?.image = image
        }
        
        return cell
    }
}

// MARK: - Collection view Delegate
// 
extension ViewController: UICollectionViewDelegate {
    
}


class CollectionCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var request: Alamofire.Request?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.addSubview(imageView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}