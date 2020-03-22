//
//  ViewController.swift
//  weather
//
//  Created by FanYu on 5/26/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
//import SwiftWeatherService
import CoreLocation

class PageContentViewController: UIViewController,CLLocationManagerDelegate {
    
    // label
    @IBOutlet weak var currentLocation: UILabel!
    //@IBOutlet weak var latitudeChinese: UILabel!
    //@IBOutlet weak var latitudeDigital: UILabel!
    //@IBOutlet weak var longitudeChinese: UILabel!
    //@IBOutlet weak var longitudeDigital: UILabel!
    
    // button title
    @IBOutlet weak var temperatureTitle: BubbleButton!
    @IBOutlet weak var humidityTitle: BubbleButton!
    @IBOutlet weak var conditionTitle: BubbleButton!
    @IBOutlet weak var windTitle: BubbleButton!
    @IBOutlet weak var pollutionTitle: BubbleButton!
    @IBOutlet weak var sunriseTitle: BubbleButton!
    @IBOutlet weak var sunsetTitle: BubbleButton!
    
    // loading stuffs
    @IBOutlet weak var tryLoading: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // weather info update when tap button
    var country: String = ""
    var tempeture: (Double, String) = (23, "") { didSet {temperatureTitle.setTitle(tempeture.1, forState: UIControlState.Highlighted) } }
    var windSpeed: Float = 0 { didSet { windTitle.setTitle("\(windSpeed)级", forState: UIControlState.Highlighted) } }
    var humidity: Int = 0 { didSet { humidityTitle.setTitle("\(humidity)%", forState: UIControlState.Highlighted) } }
    var pm2_5: Int = 0 { didSet { pollutionTitle.setTitle("PM2.5\n\(pm2_5)", forState: UIControlState.Highlighted) } }
    var conditionStr = ("", "") { didSet { conditionTitle.setTitle(conditionStr.1, forState: UIControlState.Highlighted) } }
    var up: String = "" { didSet { sunriseTitle.setTitle(up, forState: UIControlState.Highlighted) } }
    var down: String = "" { didSet { sunsetTitle.setTitle(down, forState: UIControlState.Highlighted) } }
    
    //var longitude: CLLocationDegrees = 0 { didSet { longitudeDigital.text = "\(longitude)" } }
    //var latitude: CLLocationDegrees = 0 { didSet { latitudeDigital.text = "\(latitude)" } }
    
    // pollution token
    var token: String = "5j1znBVAsnSf5xQyNQyq"
    var stations: String = "no"
    
    // servise
    let service = weatherService()
    
    // refresh
    var refreshControl: UIRefreshControl!

    // page info
    var pageIndex: Int?
    
    
    // MARK: - instant locationManager
    let locationManager: CLLocationManager = CLLocationManager()

    
    
    // MARK: - viewDidload and memoryWarning
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // status bar 
//        func preferredStatusBarStyle() ->UIStatusBarStyle {
//            return UIStatusBarStyle.LightContent
//        }
//        self.setNeedsStatusBarAppearanceUpdate()
        
        // location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // spinner indicator
        spinner.startAnimating()
        
        // refresh
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl.attributedTitle = NSAttributedString(string: "询问雷公电母中")
//        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
//        self.view.addSubview(refreshControl)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - refresh
    func refresh() {
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - get devise info
    func ios8() ->Bool {
        return UIDevice.currentDevice().systemVersion >= "8.0"
    }
    
    
    // MARK: - dataButtonTapped
    @IBAction func dataButtonTapped(sender: AnyObject) {
        switch sender.tag {
        case 0: humidityTitle.setTitle("\(humidity)%", forState: UIControlState.Highlighted)
        case 1: conditionTitle.setImage(nil, forState: UIControlState.Highlighted)
        case 2: windTitle.setTitle("\(windSpeed)级", forState: UIControlState.Highlighted)
        case 3: temperatureTitle.setImage(nil, forState: UIControlState.Highlighted)
        case 4: pollutionTitle.setImage(nil, forState: UIControlState.Highlighted)
        case 5: sunriseTitle.setTitle(up, forState: UIControlState.Highlighted)
        default : sunsetTitle.setTitle(down, forState: UIControlState.Highlighted)
        }

    }
    
    
    
    // MARK: - get sunup and sunset time
    func getSunUpSetTimeInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = "http://api.openweathermap.org/data/2.5/weather"
        let params = ["lat": latitude, "lon": longitude]
        
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { (request, response, json, error) in
                if error != nil {
                    self.sunriseTitle.setTitle("未", forState: .Normal)
                    self.sunsetTitle.setTitle("知", forState: .Normal)
                } else {
                    var json = JSON(json!)
                    var sunrise = json["sys"]["sunrise"].doubleValue
                    var sunset = json["sys"]["sunset"].doubleValue
                    print("日升\(sunrise)")
                    print("日落\(sunset)")
                    
                    var rise: NSDate = NSDate(timeIntervalSince1970: sunrise)
                    var set: NSDate = NSDate(timeIntervalSince1970: sunset)
                    
                    print("Sunrise:\(rise)")
                    print("Sunset:\(set)")
                    
                    var hourUp: Int = NSCalendar.currentCalendar().components(.Hour, fromDate: NSDate(timeIntervalSince1970: sunrise)).hour
                    var hourDown: Int = NSCalendar.currentCalendar().components(.Hour, fromDate: NSDate(timeIntervalSince1970: sunset)).hour
                    
                    var minUp: Int = NSCalendar.currentCalendar().components(.Minute, fromDate: NSDate(timeIntervalSince1970: sunrise)).minute
                    var minDown: Int = NSCalendar.currentCalendar().components(.Minute, fromDate: NSDate(timeIntervalSince1970: sunset)).minute
                    
                    var day = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: NSDate(timeIntervalSince1970: sunset)).day
                    print("day\(day)")
                    
                    print("HourUp:\(hourUp)")
                    print("HourDown:\(hourDown)")
                    print("MinUp:\(minUp)")
                    print("MinDown:\(minDown)")
                    
                    self.up = "\(hourUp):\(minUp)"
                    self.down = "\(hourDown):\(minDown)"
                    
                    var hourUpStr: String = " "
                    var hourDownStr: String = " "
                    
                    switch hourUp {
                    case 3: hourUpStr = "三时升"
                    case 4: hourUpStr = "四时升"
                    case 5: hourUpStr = "五时升"
                    case 6: hourUpStr = "六时升"
                    case 7: hourUpStr = "七时升"
                    default:hourUpStr = "无数据"
                    }
                    switch hourDown {
                    case 15: hourDownStr = "三时落"
                    case 16: hourDownStr = "四时落"
                    case 17: hourDownStr = "五时落"
                    case 18: hourDownStr = "六时落"
                    case 19: hourDownStr = "七时落"
                    case 20: hourDownStr = "八时落"
                    default:hourDownStr = "无数据"
                    }
                    
                    self.sunriseTitle.setTitle(hourUpStr, forState: .Normal)
                    self.sunsetTitle.setTitle(hourDownStr, forState: .Normal)
                }
        }
    }
    
    // MARK: - getLocationJsonInfo & updateBubbleUI
    func getLocationJsonInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = "http://api.openweathermap.org/data/2.5/forecast"
        let params = ["lon":longitude, "lat":latitude]
        print(params)
        
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { (request, response, json, error) in
                if error != nil { // cannot get data
                    self.tryLoading.text = "雷公电母睡觉中"
                    
                    print("Eoore: \(error)")
                    print(request)
                    print(response)
                } else { // successful get data
                    self.tryLoading.text = nil   // set nil
                    self.spinner.stopAnimating() // stop animating
                    self.spinner.hidden = true   // hide spinner
                    
                    var json = JSON(json!)
                    self.updateBubbleUI(json)    // call updateBubbleData
                    
                    //
                }
        }
    }
    
    func updateBubbleUI(json: JSON) {
        
        
        // if get get tempeture from JSON, assume rest of JSON is correct
        if let tempResult = json["list"][0]["main"]["temp"].double {
            
            // set longtitude and latitude
            //self.longtitudeDigital = longtitude
            
            // get country
            country = json["city"]["country"].stringValue
            
            // get city name
            let city = json["city"]["name"].stringValue
            self.currentLocation.text = city

            // get pm2.5
            self.getPollutionInfo(city, token: token, stations: stations)
            
            //get latitude and longtitude
            //self.latitudeDigital.text = json["city"]["coord"]["lat"].stringValue
            //self.longitudeDigital.text = json["city"]["coord"]["lon"].stringValue
            
            // get and convert tempeture
            tempeture = service.convertTemperature(country, temperature: tempResult)
            let temp = tempeture.0
            if country == "US" {
                self.temperatureTitle.setTitle("\(temp)℉", forState: .Normal)
            } else {
                self.temperatureTitle.setTitle("\(temp)℃", forState: .Normal)
            }
            
            // get sunrise and sunset
            //var sunrise = json["sys"]["sunrise"].floatValue
            //var sunset = json["sys"]["sunset"].floatValue
            //self.sunriseTitle.setTitle("\(sunrise)日升", forState: .Normal)
            //self.sunsetTitle.setTitle("\(sunset)日落", forState: .Normal)
            
            // get condition 
            var condition = json["list"][0]["weather"][0]["id"].intValue
            conditionStr = service.conditionJudge(condition)
            self.conditionTitle.setTitle(conditionStr.0, forState: .Normal)
            
            // get wind
            windSpeed = json["list"][0]["wind"]["speed"].floatValue
            var windStr = service.windJudge(windSpeed)
            self.windTitle.setTitle(windStr, forState: .Normal)
            
            // get humidity 
            humidity = json["list"][0]["main"]["humidity"].intValue
            var humidityStr = service.humidityJudge(humidity)
            self.humidityTitle.setTitle("\(humidityStr)", forState: .Normal)
            
            // get forecast
//            for index in 1...7 {
//                println(json["list"][index])
//                
//            }
        }
    }
    
    func getPollutionInfo(city: String, token: String, stations: String) {
        let url = "http://www.pm25.in/api/querys/pm2_5.json"
        let params = ["city":city, "token":token, "stations":stations]
        
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { (request, response, json, error) in
                if let errStr = error {
                    self.pollutionTitle.setTitle("无数据", forState: .Normal)
                    print("污染错误信息: \(errStr)")
                } else {
                    let json = JSON(json!)
                    
                    self.pm2_5 = json["pm2_5"].intValue
                    var pmStr = self.service.pollutionJudge(self.pm2_5)
                    self.pollutionTitle.setTitle("\(pmStr)", forState:.Normal )
                    print("PM2.5: \(self.pm2_5)")
                }
            }
    }
    
//    func updateConditionInfo(index: Int, name: String) {
//        switch index {
//        case 0: 
//        }
//    }
    
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count - 1] 
        
        if location.horizontalAccuracy > 0 { //the location is valid
            // stop updating after successful load
            self.locationManager.stopUpdatingLocation()
            
            // get longtitude and latitude
            //longitude = location.coordinate.longitude
            //latitude = location.coordinate.latitude
            
            //longitudeDigital.text = "\(longitude)"
            //latitudeDigital.text = "\(latitude)"
            
            // getlocationJsonInfo from location coordinate
            getLocationJsonInfo(location.coordinate.latitude, longitude: location.coordinate.longitude)
            // get sun up set time
            getSunUpSetTimeInfo(location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Somthing wrong: \(error)")
    }

}
