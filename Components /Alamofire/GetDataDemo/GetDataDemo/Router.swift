//
//  Router.swift
//  GetDataDemo
//
//  Created by FanYu on 25/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//
import Alamofire

// 路由，它为我们的 API 调用方法创建合适的URLString实例
//
struct FYPhotos {
    enum Router: URLRequestConvertible {
        
        // 两个静态常量：API 的baseURLString以及consumerKey
        static let basicURLString = "https://api.500px.com/v1"
        static let key = "HelloWorld"
        
        case PopularPhotos(Int)
        case PhotoInfo(Int, String)
        case Comments(Int, Int)
        
        var URLRequest: NSMutableURLRequest {
            let result: (path: String, parameters: [String : AnyObject]) = {
                switch self {
                case .PopularPhotos(let page):
                    let params = ["consumer_key"    : Router.key,
                                  "page"            : "\(page)",
                                  "feature"         : "popular",
                                  "rpp"             : "50",
                                  "include_store"   : "store_download",
                                  "include_states"  : "votes"]
                    return ("/photos", params)
                    
                case .PhotoInfo(let photoID, let imageSize):
                    let params = ["consumer_key"    : Router.key,
                                  "image_size"      : imageSize]
                    return ("/photos/\(photoID)", params)
                    
                case .Comments(let photoID, let commentsPage):
                    let params = ["consumer_key"    : Router.key,
                                  "comments"        : "1",
                                  "comments_page"   : "\(commentsPage)"]
                    return ("/photos/\(photoID)/comments", params)
                }
            }()
            
            let URL = NSURL(string: Router.basicURLString)!
            let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: result.parameters).0
        }
    }
}
// Five100px.Router.PhotoInfo(10000, Five100px.ImageSize.Large)
// URL: https://api.500px.com/v1/photos/10000?consumer_key=xxxxxx&image_size=4
// https://api.500px.com/v1  +  /photos/10000  +  ?consumer_key=xxxxxx&image_size=4
// = baseURLString  +  path  +  encoded parameters
