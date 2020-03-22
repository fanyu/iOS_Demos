//
//  WeatherService.swift
//  BubbleWeather2Test
//
//  Created by FanYu on 8/2/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import Foundation
import CoreLocation
//import Alamofire
//import SwiftyJSON
import CoreData
import UIKit
import Social
import MessageUI


public class weatherService {

    static func saveContext() {
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }

    static func initializeDatabaze() {
        let c = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var u =  NSEntityDescription.insertNewObjectForEntityForName(cUser.User, inManagedObjectContext: c) as! User
        u.uChosenLocationID =  cUser.ChosenLocationCurrent
        saveContext()
    }
}
