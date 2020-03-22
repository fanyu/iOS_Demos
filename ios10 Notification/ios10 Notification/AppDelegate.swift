//
//  AppDelegate.swift
//  ios10 Notification
//
//  Created by FanYu on 9/30/16.
//  Copyright © 2016 SRT. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        UIApplication.shared.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print(settings.authorizationStatus)
            print(settings.badgeSetting)
        }
        
        registerNotification()
        schedualLocalNotification(str: "hhhhhhhh")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
        
    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Token \(deviceToken.hexString)")
    }
}


//
extension AppDelegate {
    
    func registerNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                // 用户运行通知
            }
        }
    }
    
    func schedualLocalNotification(str: String) {
        // 1. 创建通知内容
        let content = UNMutableNotificationContent();
        content.title = "Hello"
        content.body = "World"
        content.userInfo = ["name": "onevcat"]
        content.categoryIdentifier = "saySomethingCategory"

        // 2. 创建发送触发
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // 3. 发送请求标识符
        let requestIdentifier = "com.onevcat.usernotification.myFirstNotification"
        
        // 4. 创建一个发送请求
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 将请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil {
                print("No error")
            }
        }
    }
    
    func notificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print(settings.authorizationStatus) // .authorized | .denied   | .notDetermined
            print(settings.badgeSetting)        // .enabled    | .disabled | .notSupported
        }
    }
    
    // actions
    func registerNotificationCategory() {
        let saySomethingCategory: UNNotificationCategory = {
            // 1
            let inputAction = UNTextInputNotificationAction(
                identifier: "action.input",
                title: "Input",
                options: [.foreground],
                textInputButtonTitle: "Send",
                textInputPlaceholder: "What do you want to say...")
            
            // 2
            let goodbyeAction = UNNotificationAction(
                identifier: "action.goodbye",
                title: "Goodbye",
                options: [.foreground])
            
            let cancelAction = UNNotificationAction(
                identifier: "action.cancel",
                title: "Cancel",
                options: [.destructive])
            
            // 3
            return UNNotificationCategory(identifier:"saySomethingCategory", actions: [inputAction, goodbyeAction, cancelAction], intentIdentifiers: [], options: [.customDismissAction])
        }()
        
        UNUserNotificationCenter.current().setNotificationCategories([saySomethingCategory])
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    // 对通知进行响应
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let name = response.notification.request.content.userInfo["name"] as? String {
            print("I know it's you! \(name)")
        }
        
        if let category = UNNotification
        
        completionHandler()
    }
    
    // 应用内展示通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert, .sound])

        // 如果不想显示某个通知，可以直接用空 options 调用 completionHandler:
        // completionHandler([])
    }
}



extension Data {
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}
