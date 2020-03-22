//
//  WeChatActivity.swift
//  SocialShare
//
//  Created by FanYu on 3/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import MonkeyKing

class WeChatActivity: AnyActivity {
    
    enum Type {
        
        case Session
        case Timeline
        
        var type: String {
            switch self {
            case .Session:
                return "com.nixWork.China.WeChat.Session"
            case .Timeline:
                return "com.nixWork.China.WeChat.Timeline"
            }
        }
        
        var title: String {
            switch self {
            case .Session:
                return NSLocalizedString("WeChat Session", comment: "")
            case .Timeline:
                return NSLocalizedString("WeChat Timeline", comment: "")
            }
        }
        
        var image: UIImage {
            switch self {
            case .Session:
                return UIImage(named: "wechat_session")!
            case .Timeline:
                return UIImage(named: "wechat_timeline")!
            }
        }
    }
    
    init(type: Type, message: MonkeyKing.Message, completionHandler: MonkeyKing.SharedCompletionHandler) {
        
        MonkeyKing.registerAccount(.WeChat(appID: Configs.Wechat.appID, appKey: ""))
        
        super.init(
            type: type.type,
            title: type.title,
            image: type.image,
            message: message,
            completionHandler: completionHandler
        )
    }
}
