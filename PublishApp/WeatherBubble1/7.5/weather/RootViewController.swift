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
import CoreLocation
import Social
import MessageUI

class RootViewController: UIViewController,CLLocationManagerDelegate, MFMailComposeViewControllerDelegate {
    
    // hours 
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
    
    // label
    @IBOutlet weak var currentLocation: UILabel!
    
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

    var windSpeed: Float = 0 { didSet { windTitle.setTitle("\(windSpeed)级", forState: UIControlState.Highlighted) } }
    
    var humidity: Int = 0 { didSet { humidityTitle.setTitle("\(humidity)%", forState: UIControlState.Highlighted) } }
    
    var pm2_5: Int = 0 { didSet { pollutionTitle.setTitle("PM2.5\n\(pm2_5)", forState: UIControlState.Highlighted) } }
    
    var clouds = 2 { didSet { conditionTitle.setTitle("云\(clouds)%", forState: UIControlState.Highlighted) } }
    
    var up: String = "" { didSet { sunriseTitle.setTitle(up, forState: UIControlState.Highlighted) } }
    var down: String = "" { didSet { sunsetTitle.setTitle(down, forState: UIControlState.Highlighted) } }
    
    // refresh
    var refreshControl: UIRefreshControl!
    
    // first time launch 
    var appFirstTimeLaunched = true
    var canUpdateUI = true
    
    // MARK: - instant locationManager
    let locationManager: CLLocationManager = CLLocationManager()

    
    // MARK: - dataButtonTapped
    @IBAction func dataButtonTapped(sender: AnyObject) {
        switch sender.tag {
        case 0: humidityTitle.setTitle("\(humidity)%", forState: UIControlState.Highlighted)
        case 1: conditionTitle.setImage(nil, forState: UIControlState.Highlighted)
        case 2: windTitle.setTitle("\(windSpeed)级", forState: UIControlState.Highlighted)
        //case 3: temperatureTitle.setImage(nil, forState: UIControlState.Highlighted)
        case 4: pollutionTitle.setImage(nil, forState: UIControlState.Highlighted)
        case 5: sunriseTitle.setTitle(up, forState: UIControlState.Highlighted)
        default : sunsetTitle.setTitle(down, forState: UIControlState.Highlighted)
        }
    }

    // segueButton
    @IBOutlet weak var segueButton: UIButton!
    var firstLaunch: Bool = true
    
    // MARK: - viewDidload and memoryWarning
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        if CLLocationManager.authorizationStatus() == .Denied {
            let settingUrl = NSURL(string: UIApplicationOpenSettingsURLString)
            if let url = settingUrl {
                UIApplication.sharedApplication().openURL(url)
            }
            tryLoading.text = "Location not determined"
        }
        
        // spinner indicator
        spinner.startAnimating()
        
        // first launch
        segueButton.hidden = true
        
        // hours hidden
        HoursHidden(true)
        
        // notificaiton 
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectedCityChanged", name: cGeneral.ChangeSelectedCity, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.canBecomeFirstResponder()
    }
    
    
    // MARK: - Hours Info
    @IBOutlet var HourslongPress: UILongPressGestureRecognizer!
    
    @IBAction func HoursLongPressGesture(sender: AnyObject) {
        if HourslongPress.state == UIGestureRecognizerState.Began{
            HoursHidden(false)
        } else {
            HoursHidden(true)
        }
    }
    
    func HoursHidden(YooN: Bool) {
        time1.hidden = YooN
        time2.hidden = YooN
        time3.hidden = YooN
        time4.hidden = YooN
        time5.hidden = YooN
        temp1.hidden = YooN
        temp2.hidden = YooN
        temp3.hidden = YooN
        temp4.hidden = YooN
        temp5.hidden = YooN
        cond1.hidden = YooN
        cond2.hidden = YooN
        cond3.hidden = YooN
        cond4.hidden = YooN
        cond5.hidden = YooN
    }
    
    func updataHoursInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
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
                    var temp = weatherService.convertTemperature(country, temperature: temperature)
                    
                    // get condition
                    var conds = json["list"][index]["weather"][0]["description"].stringValue
                    var condition = conds.componentsSeparatedByString("，")[0]
                    
                    // get time
                    var timeInterval = json["list"][index]["dt"].doubleValue
                    var time = weatherService.hoursTimeFormate(timeInterval)
                    
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
                println("Today Weather info is not available!")
            }
        }
    }


    // MARK: - Shake iPhone
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == UIEventSubtype.MotionShake {
            //println("Shake Shake Shake it off")
            let FBViewControllers = feedBackViewControllers()
            weatherService.shakeToShow(self, mailFeedBackViewController: FBViewControllers.mail, weiboFeedBackViewController: FBViewControllers.weibo)
        }
    }
    
    // MARK: - Mail and WeiBo FeedBack
    func feedBackViewControllers() ->(mail: MFMailComposeViewController, weibo: SLComposeViewController) {
        let deviceModel = UIDevice.currentDevice().model
        let deviceSystemVersion = UIDevice.currentDevice().systemVersion
        
        // mail
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = self
        mailViewController.setToRecipients(["edcfanyu@gmail.com"])
        mailViewController.setSubject("天气泡问题反馈")
        mailViewController.setMessageBody("\(deviceModel), iOS\(deviceSystemVersion), 问题反馈：", isHTML: false)
        
        // weibo
        var weiboViewController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
        weiboViewController.setInitialText("@天气泡 \(deviceModel), iOS\(deviceSystemVersion)：")

        return (mailViewController, weiboViewController)
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // MARK: - Update Info
    func appBecomeActive() {
        if appFirstTimeLaunched == true {
            appFirstTimeLaunched = false
            return
        }
        canUpdateUI = true
        // it's the current location
        if User.getUser()?.uChosenLocationID.integerValue == cUser.ChosenLocationCurrent {
            locationManager.startUpdatingLocation()
        } else { // other location
            updateUI()
        }
    }
    
    func updateUI() {
        var url: String?
        if let u = User.getUser() where u.uChosenLocationID.integerValue == cUser.ChosenLocationCurrent {
            url = "http://api.openweathermap.org/data/2.5/weather?lat=" + u.uCurrentLatitude.description + "&lon=" + u.uCurrentLongitude.description + "&lang=zh_cn"
        } else {
            url  = "http://api.openweathermap.org/data/2.5/weather?id=" + (User.getUser()?.uChosenLocationID.stringValue ?? "") + "&lang=zh_cn"
        }
        
        Alamofire.request(.GET, url!).responseJSON() {
            (_, _, json, error) in
            if error != nil { // cannot get data
                weatherService.showAlertWithText("抱歉", controllerText: "雷公电母休息中", actionTitle: "检查网络", sender: self)
            } else { // successful get data
                
                self.segueButton.hidden = false
                self.tryLoading.text = nil   // set nil
                self.spinner.stopAnimating() // stop animating
                self.spinner.hidden = true   // hide spinner
        
                var u = User.getUser()
                var json = JSON(json!)
                
                if let tempResult = json["main"]["temp"].double {
                                        
                    // get country
                    self.country = json["sys"]["country"].stringValue
                    
                    // get city name
                    var city = json["name"].stringValue
                    self.currentLocation.text = city
                    u?.uChosenLocationName = city
                    
                    // get pollution
                    var pollutionInfo = self.getPollutionInfo(city.lowercaseString, token: pm25Params.token, stations: pm25Params.stations)
                    //self.pollutionTitle.setTitle("\(pollutionInfo.str)", forState: .Normal)
                    self.pm2_5 = pollutionInfo.pm2_5
                    u?.uCurrentPollution = pollutionInfo.str
                    
                    // get and convert tempeture
                    let temp = weatherService.convertTemperature(self.country, temperature: tempResult)
                    self.temperatureTitle.setTitle("\(temp)º", forState: .Normal)
                    u?.uCurrentTemperature = "\(temp)"
                    
                    // get condition
                    var description = json["weather"][0]["description"].stringValue
                    var condition = description.componentsSeparatedByString("，")[0]
                    self.conditionTitle.setTitle(condition, forState: .Normal)
                    u?.uCurrentCondition = condition
                    self.clouds = json["clouds"]["all"].intValue
                    
                    // get wind
                    self.windSpeed = json["wind"]["speed"].floatValue
                    var windStr = weatherService.windJudge(self.windSpeed)
                    self.windTitle.setTitle(windStr, forState: .Normal)
                    u?.uCurrentWind = windStr
                    
                    // get humidity 
                    self.humidity = json["main"]["humidity"].intValue
                    var humidityStr = weatherService.humidityJudge(self.humidity)
                    self.humidityTitle.setTitle("\(humidityStr)", forState: .Normal)
                    u?.uCurrentHumidity = humidityStr
                    
                    // get sunrise and sunset 
                    var sunrise = json["sys"]["sunrise"].doubleValue
                    var sunset = json["sys"]["sunset"].doubleValue
                    var upSet = weatherService.sunUpSetTime(sunrise, sunSet: sunset)
                    self.sunriseTitle.setTitle(upSet.up, forState: .Normal)
                    self.sunsetTitle.setTitle(upSet.down, forState: .Normal)
                    self.up = upSet.riseTime
                    self.down = upSet.setTime
                    
                    weatherService.saveContext()
                    
                    // need to reload forecast data
                    NSNotificationCenter.defaultCenter().postNotificationName(cGeneral.NeedReloadForecastTVC, object: nil)
                }
            }
        }
        
        
    }
    
    func getPollutionInfo(city: String, token: String, stations: String) ->(str:String, pm2_5: Int) {
        let url = "http://www.pm25.in/api/querys/pm2_5.json"
        let params = ["city":city, "token":token, "stations":stations]
        var pmStr = ""
        var pm2_5 = 0
        var aqi = 0
        
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { (request, response, json, error) in
                if let errStr = error {
                    pmStr = "无数据"
                    pm2_5 = 0
                    self.pollutionTitle.setTitle("\(pmStr)", forState: .Normal)
                } else {
                    let json = JSON(json!)
                    
                    pm2_5 = json[0]["pm2_5"].intValue
                    //var c = json[0]["area"].stringValue
                    //pmStr = json[0]["quality"].stringValue
                    aqi = json[0]["aqi"].intValue
                    self.pm2_5 = pm2_5
                    
                    if aqi < 50 {
                        pmStr = "空气优"
                    } else if aqi < 100 {
                        pmStr = "空气良"
                    } else if aqi < 150 {
                        pmStr = "轻污染"
                    } else if aqi < 200 {
                        pmStr = "中污染"
                    } else if aqi < 250 {
                        pmStr = "重污染"
                    } else {
                        pmStr = "严重污染"
                    }
                    self.pollutionTitle.setTitle("\(pmStr)", forState: .Normal)
                }
        }
        return (pmStr, pm2_5)
    }

    
    func selectedCityChanged() {
        canUpdateUI = true
        if User.getUser()?.uChosenLocationID.integerValue == cUser.ChosenLocationCurrent {
            locationManager.startUpdatingLocation()
        } else {
            updateUI()
        }
    }
    
    
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location: CLLocation = locations[locations.count - 1] as! CLLocation
        
        if location.horizontalAccuracy > 0 { //the location is valid
            
            if canUpdateUI == true && locations.count > 0 {
                canUpdateUI = false
                
                // stop updating after successful load
                self.locationManager.stopUpdatingLocation()
                
                // getlocationJsonInfo from location coordinate
                var u = User.getUser()
                u?.uCurrentLatitude = (locations.first as? CLLocation)?.coordinate.latitude ?? 0
                u?.uCurrentLongitude = (locations.first as? CLLocation)?.coordinate.longitude ?? 0
                
                updataHoursInfo(location.coordinate.latitude, longitude: location.coordinate.longitude)
                
                weatherService.saveContext()
                updateUI()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        //println("hey, Somthing wrong: \(error)")
    }

}
