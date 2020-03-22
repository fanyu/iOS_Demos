//
//  Serializer.swift
//  GetDataDemo
//
//  Created by FanYu on 25/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import Alamofire
import UIKit

// 自定义响应序列化方法
// 直接接收UIImage，而不是将UIImage转化为NSData来接收
extension Alamofire.Request {
    
    class func imageResponseSerializer() -> ResponseSerializer<UIImage?, NSError> {
        
        return ResponseSerializer { request, response, data, error in
            // 确保没有错误
            guard error == nil else { return .Failure(error!) }
            
            // 确保数据不为空
            guard let validData = data else {
                let failureReason = "数据无法被序列化，因为接收到的数据为空"
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            // 把获取的 Data 直接转化为image
            let image = UIImage(data: validData, scale: UIScreen.mainScreen().scale)
            return .Success(image)
        }
    }
    
    public func responseImage(completionHandler: Response<UIImage?, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.imageResponseSerializer(), completionHandler: completionHandler)
    }
}