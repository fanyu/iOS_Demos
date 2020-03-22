//
//  TodayViewController.swift
//  weatherTodayWidget
//
//  Created by FanYu on 7/1/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation
import Alamofire
import SwiftyJSON

class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate {
    
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var time3: UILabel!
    @IBOutlet weak var time4: UILabel!
    @IBOutlet weak var time5: UILabel!
    
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var temp2: UILabel!
    @IBOutlet weak var temp3: UILabel!
    @IBOutlet weak var temp4: UILabel!
    @IBOutlet weak var temp5: UILabel!
    
    @IBOutlet weak var cond1: UILabel!
    @IBOutlet weak var cond2: UILabel!
    @IBOutlet weak var cond3: UILabel!
    @IBOutlet weak var cond4: UILabel!
    @IBOutlet weak var cond5: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingHeading()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertTemperature(country: String, temperature: Double) ->String {
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

    func hoursTimeFormate(timeInterval: Double) ->String {
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
    
    func updataNotificationCenter(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = "http://api.openweathermap.org/data/2.5/forecast?lat=" + latitude.description + "&lon=" + longitude.description + "&lang=zh_cn"
        
        Alamofire.request(.GET, url).responseJSON {
            (_, _, json, err) in
            if err == nil {
                var json = JSON(json!)
                
                // get country
                let country = json["city"]["name"].stringValue
                
                // get city
                let city = json["country"].stringValue
                
                // Get forecast
                for index in 0...4 {
                    // Get and convert temperature
                    var temperature = json["list"][index]["main"]["temp"].doubleValue
                    var temp = self.convertTemperature(country, temperature: temperature)
                    
                    // get condition
                    var conds = json["list"][index]["weather"][0]["description"].stringValue
                    var condition = conds.componentsSeparatedByString("，")[0]
                    
                    // get time
                    var timeInterval = json["list"][index]["dt"].doubleValue
                    var time = self.hoursTimeFormate(timeInterval)
                    
                    if index==0 {
                        self.temp1.text = "\(temp)°"
                        self.cond1.text = "\(condition)"
                        self.time1.text = "\(time)"
                    }
                    else if index==1 {
                        self.temp2.text = "\(temp)°"
                        self.cond2.text = "\(condition)"
                        self.time2.text = "\(time)"
                    }
                    else if index==2 {
                        self.temp3.text = "\(temp)°"
                        self.cond3.text = "\(condition)"
                        self.time3.text = "\(time)"
                    }
                    else if index==3 {
                        self.temp4.text = "\(temp)°"
                        self.cond4.text = "\(condition)"
                        self.time4.text = "\(time)"
                    }
                    else if index==4 {
                        self.temp5.text = "\(temp)°"
                        self.cond5.text = "\(condition)"
                        self.time5.text = "\(time)"
                        //println("\(condition)")
                    }
                }
                
            } else {
                print("Today Weather info is not available!")
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count - 1] 
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            updataNotificationCenter(location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        // pull down to update
        locationManager.startUpdatingLocation()
        
        completionHandler(NCUpdateResult.NewData)
    }
    
}