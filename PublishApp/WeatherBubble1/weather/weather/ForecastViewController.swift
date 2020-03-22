//
//  ForecastViewController.swift
//  
//
//  Created by FanYu on 6/26/15.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class ForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func tapGesture(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet weak var hidedText: UILabel!

    
    // 1 = Sunday, adjusted to our structure -> added +1
    let dateOfWeek = weatherService.getDayOfWeek() - 1
    var days = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
    var data = [[NSObject: AnyObject?]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidedText.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "needReloadData", name: cGeneral.NeedReloadForecastTVC, object: nil)
        updateUI()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        activity.startAnimating()
    }
    
    func orientationChanged() ->CGFloat{
        var cellSize: CGFloat
        let orientation = UIDevice.currentDevice().orientation
        let deviseHeight = UIScreen.mainScreen().bounds.height

        if UIDeviceOrientationIsLandscape(orientation) {
            switch deviseHeight {
            case 320: cellSize = 45 // 4
            case 375: cellSize = 52 // 6
            case 414: cellSize = 58// 6+
            default: cellSize  = 70// ipad
            }
        } else {
            switch deviseHeight {
            case 480: cellSize = 69 // 4 55
            case 568: cellSize = 80 // 5 69
            case 667: cellSize = 94 // 6 83
            case 736: cellSize = 100 // plus 93
            default: cellSize = 120 // ipad 100
            }
        }
        
        return cellSize
    }
    
    func updateUI() {
        
        data.removeAll(keepCapacity: true)
        let u = User.getUser()
        var url = ""
        if let user = u where user.uChosenLocationID.integerValue == cUser.ChosenLocationCurrent{
            
            url = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=" + user.uCurrentLatitude.description + "&lon=" + user.uCurrentLongitude.description + "&lang=zh_cn"
            
        } else {
            
            url = "http://api.openweathermap.org/data/2.5/forecast/daily?id=" + (User.getUser()?.uChosenLocationID.stringValue ?? "") + "&lang=zh_cn"
        }
        
        Alamofire.request(.GET, url).responseJSON() {
            (_, _, json, e) in
            if e == nil {
                
                self.activity.stopAnimating()
                self.activity.hidden = true
                
                var json = JSON(json!)
                var list = json["list"]
                if list.count > 5 {
                    for i in 0...6 {
                        var country = json["country"].stringValue
                        var city = json["city"]["name"].stringValue
                        var temp = weatherService.convertTemperature(country, temperature: list[i]["temp"]["day"].doubleValue).0
                        var tempMin = weatherService.convertTemperature(country, temperature: list[i]["temp"]["min"].doubleValue).0
                        var tempMax = weatherService.convertTemperature(country, temperature: list[i]["temp"]["max"].doubleValue).0
                        
                        var description = list[i]["weather"][0]["description"].stringValue
                        var condition = description.componentsSeparatedByString("，")[0]
                        
                        
                        self.data.append([
                            cForecast.kTemp: temp,
                            cForecast.KTempLow: tempMin,
                            cForecast.KTempHigh: tempMax,
                            cForecast.kDesc: condition,
                            ])
                    }
                    self.tableView.reloadData()
                }
            } else {
                weatherService.showAlertWithText("抱歉", controllerText: "雷公电母休息中", actionTitle: "检查网络", sender: self)
            }

        }
    }
    
    func needReloadData() {
        updateUI()
    }


    // MARK: - UITableView Protocols
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ForecastCell") as! ForecastCell
        
        cell.iDay.text = days[(indexPath.row + dateOfWeek) % 7]
        cell.iTemperatureLow.text = data[indexPath.row][cForecast.KTempLow] as? String
        cell.iTemperatureHigh.text = data[indexPath.row][cForecast.KTempHigh] as? String
        cell.iCondition.text = data[indexPath.row][cForecast.kDesc] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        let cell = orientationChanged()
        return cell
    }
}
