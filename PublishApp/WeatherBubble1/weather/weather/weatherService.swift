//
//  service.swift
//  weatherBubble
//
//  Created by FanYu on 7/2/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON
import CoreData
import UIKit
import Social
import MessageUI

struct cGeneral {
    static let ChangeUnitNotification = "ChangeUnitNotification"
    static let ChangeSelectedCity = "ChangeSelectedCity"
    static let NeedReloadForecastTVC = "NeedReloadForecastVC"
    static let appBlackColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
}

public enum Status {
    case success
    case failure
}

struct cForecast {
    static let kTemp = "temp"
    static let KTempLow = "tempLow"
    static let KTempHigh = "tempHigh"
    static let kDesc = "desc"
    static let kPoll = "poll"
}

struct pm25Params {
    static let token = "MEyYUDdpqm3jyyjziatG"
    static let stations = "no"
    
}
public class Response {
    public var status: Status?
    public var object: JSON?
    public var error: NSError?
}

public class weatherService {
    
    static func shareToWeibo(view: UIView) ->SLComposeViewController {
        let shareControler: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
        shareControler.setInitialText("#天气泡#")
        let image = screenShot(view)
        shareControler.addImage(image)
        return shareControler
    }
    
    static func screenShot(view: UIView) ->UIImage {
        // create the uiimage
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0)
        // get the context
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        // get the image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    static func humidityJudge(humidity: Int) ->String {
        if humidity <= 20 {
            return "极干燥"
        } else if humidity <= 40 {
            return "较干燥"
        } else if humidity <= 50 {
            return "较潮湿"
        } else if humidity <= 70 {
            return "湿度大"
        } else {
            return "极潮湿"
        }
    }
    
    static func windJudge(windSpeed: Float) ->String {
        if windSpeed < 1 {
            return "无风"
        } else if windSpeed < 12 {
            return "轻风"
        } else if windSpeed < 20 {
            return "微风"
        } else if windSpeed < 29 {
            return "和风"
        } else if windSpeed < 39 {
            return "清风"
        } else if windSpeed < 50 {
            return "强风"
        } else if windSpeed < 62 {
            return "疾风"
        } else if windSpeed < 75 {
            return "大风"
        } else if windSpeed < 89 {
            return "烈风"
        } else if windSpeed < 103 {
            return "狂风"
        } else if windSpeed < 118 {
            return "暴风"
        } else {
            return "飓风"
        }
    }
    
    
    
    static func convertTemperature(country: String, temperature: Double) ->String {
        var temp: String?
        var convertedT: Int?
        if country == "US" {
            convertedT = Int(round(((temperature - 273.5) * 1.8) + 32))
            temp = "\(convertedT!)"
        } else {
            convertedT = Int(round(temperature - 273.5))
            temp = "\(convertedT!)"
        }
        
        return temp!
    }
    
    
    static func hoursTimeFormate(timeInterval: Double) ->String {
        let rowDate = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormater = NSDateFormatter()
        let language: String = NSLocale.preferredLanguages()[0] 
        var time: String?
        
        if language == "zh-Hans" {
            dateFormater.dateFormat = "ah"
        } else {
            dateFormater.dateFormat = "ha"
        }
        time = dateFormater.stringFromDate(rowDate)
        
        return time!
    }
    
    static func sunUpSetTime(sunRise: Double, sunSet: Double) ->(up: String, down: String, riseTime: String, setTime: String) {
        
        let dataFormater = NSDateFormatter()
        dataFormater.dateFormat = "h:mm"
        
        let riseTime = dataFormater.stringFromDate(NSDate(timeIntervalSince1970: sunRise))
        let setTime = dataFormater.stringFromDate(NSDate(timeIntervalSince1970: sunSet))
        
        let riseHour = riseTime.componentsSeparatedByString(":")[0]
        let setHour = setTime.componentsSeparatedByString(":")[0]
        
        var hourUpStr: String?
        var hourDownStr: String?
        
        
        if riseHour == "3" || riseHour == "03" {
            hourUpStr = "三时日出"
        } else if riseHour == "4" || riseHour == "04" {
            hourUpStr = "四时日出"
        } else if riseHour == "5" || riseHour == "05" {
            hourUpStr = "五时日出"
        } else if riseHour == "6" || riseHour == "06" {
            hourUpStr = "六时日出"
        } else if riseHour == "7" || riseHour == "07" {
            hourUpStr = "七时日出"
        } else if riseHour == "8" || riseHour == "08" {
            hourUpStr = "八时日出"
        } else if riseHour == "9" || riseHour == "09" {
            hourUpStr = "九时日出"
        } else {
            hourUpStr = "无数据"
        }
        
        if setHour == "3" || setHour == "15" {
            hourDownStr = "三时日落"
        } else if setHour == "4" || setHour == "16" {
            hourDownStr = "四时日落"
        } else if setHour == "5" || setHour == "17" {
            hourDownStr = "五时日落"
        } else if setHour == "6" || setHour == "18" {
            hourDownStr = "六时日落"
        } else if setHour == "7" || setHour == "19" {
            hourDownStr = "七时日落"
        } else if setHour == "8" || setHour == "20" {
            hourDownStr = "八时日落"
        } else if setHour == "9" || setHour == "21" {
            hourDownStr = "九时日落"
        } else {
            hourDownStr = "无数据"
        }
        
        return (hourUpStr!, hourDownStr!, riseTime, setTime)
    }
        
    
    static func getDayOfWeek() ->Int {
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let myWeek = myCalendar!.component(NSCalendarUnit.Weekday, fromDate: todayDate)
        return myWeek
    }
    
    static func saveContext() {
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
    
    static func initializeDatabaze() {
        
        let c = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        let u =  NSEntityDescription.insertNewObjectForEntityForName(cUser.User, inManagedObjectContext: c) as! User
        u.uChosenLocationID =  cUser.ChosenLocationCurrent
        saveContext()
    }
    
    static func showAlertWithText(controllerTitile: String, controllerText: String, actionTitle: String, sender: AnyObject) {
        
        let a = UIAlertController(title: controllerTitile, message: controllerText ?? "", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "检查网络", style: .Default, handler: { (ok) -> Void in})
        a.addAction(ok)
        if let s = sender as? UIViewController {
            sender.presentViewController(a, animated: true, completion: nil)
        }
    }
    
    static func shakeToShow(sender: AnyObject, mailFeedBackViewController: MFMailComposeViewController, weiboFeedBackViewController: SLComposeViewController) {
        let alertController = UIAlertController(title: "反馈与点评", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        var sysInfo = UIDevice.currentDevice().systemVersion
        // email
        let emailFeedBackAction = UIAlertAction(title: "邮件反馈", style: UIAlertActionStyle.Default, handler: { (ok) -> Void in
            if mailFeedBackViewController.canResignFirstResponder() {
                sender.presentViewController(mailFeedBackViewController, animated: true, completion: nil) 
            }
        } )
        
        // weibo
        let weiboFeedBackAction = UIAlertAction(title: "微博吐槽", style: UIAlertActionStyle.Default, handler: { (ok) -> Void in
            sender.presentViewController(weiboFeedBackViewController, animated: true, completion: nil)
        } )
        
        let appleStoreAction = UIAlertAction(title: "我要点评", style: UIAlertActionStyle.Default, handler: { (ok) -> Void in
            let iTunesLink: String = "itms-apps://geo.itunes.apple.com/cn/app/tian-qi-pao/id1013763695?ls=1&mt=8"
            //"itms-apps://itunes.apple.com/app/bars/id706081574"
            UIApplication.sharedApplication().openURL(NSURL(string: iTunesLink)!)
        })
        
        // cancle
        let cancleAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Destructive, handler: nil)
        
        alertController.addAction(emailFeedBackAction)
        alertController.addAction(weiboFeedBackAction)
        alertController.addAction(appleStoreAction)
        alertController.addAction(cancleAction)
        
        sender.presentViewController(alertController, animated: true, completion: nil)
    }
}
