//
//  NetWorkSpeedMonitor.swift
//  NetSpeedMonitor
//
//  Created by FanYu on 30/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

struct NetWorkBytes {
    var inBytes: UInt64
    var outBytes: UInt64
}

class NetWorkSpeedMonitor: NSObject {

    var bytesPerSecond: UInt64!
    var networkBytesPerSecond: NetWorkBytes!
    
    var timer = NSTimer()
    var timerGCD: dispatch_source_t!
    var gapOfTimer: NSTimeInterval!
    
    var isMonitoring: Bool = false
    
    var bytes = (0,0)
    
    override init() {
        super.init()
        
        isMonitoring = false
        gapOfTimer = NSTimeInterval(integerLiteral: 1)
        
    }
    
    func sharedMonitor() -> NetWorkSpeedMonitor {
        var sharedMonitor: NetWorkSpeedMonitor!
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) { () -> Void in
            print("\(NSDate()) /t Dispatch Once ")
            sharedMonitor = NetWorkSpeedMonitor()
        }
        
        return sharedMonitor
    }
    
    func setupTimer(timer: NSTimer) {
        
        if self.timer != timer {
            self.timer.invalidate()
            self.timer = NSTimer()
        }
        
        self.timer = timer
    }
    
    func setupGCD(timerGCD: dispatch_source_t) {
        if (self.timerGCD != nil) {
            
        }
        
        self.timerGCD = timerGCD
    }
    
//    func speedStr() -> NSString {
//        //return
//    }
    
    func startMonitor() {
        if isMonitoring {
            let period: NSTimeInterval = 1.0
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
            
            dispatch_source_set_timer(timer, 0, UInt64(2.0 * Double(NSEC_PER_SEC)), 0)
            
            dispatch_source_set_event_handler(timer, { () -> Void in
                // execute
            })
            
            dispatch_resume(timer)
            
            self.timerGCD = timer
            self.isMonitoring = true
        }
    }
    
    func stopMonitor() {
        self.timerGCD = nil
        self.isMonitoring = false
    }
    
    private func monitorNetWorkSpeed() {
        
    }
    
    private func getBytes() -> NetWorkBytes {
        let lastTime = 0
        
    }
    
    private func getGPRSBytes() {
        
    }
}
