//
//  ListOfCitiesViewController.swift
//  
//
//  Created by FanYu on 6/12/15.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
//    @IBAction func tapGesture(sender: AnyObject) {
//        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
//    }
    
    var data = SavedCity.getAllCities() ?? [SavedCity]()
    var currentData = [[NSObject: AnyObject?]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
        
        //tableView.addSubview(self.tableView.tableFooterView!)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        data = SavedCity.getAllCities() ?? [SavedCity]()
        tableView.reloadData()
        
        
        var allCities = SavedCity.getAllCities()
        if let cities = allCities where cities.count > 0 {
            var idValues = [String]()
            currentData.removeAll(keepCapacity: true)
            for c in cities {
                idValues.append(c.sID.stringValue)
            }
            
            // multiple city id
            let url = "http://api.openweathermap.org/data/2.5/group?id=" + (",".join(idValues))
            Alamofire.request(.GET, url).responseJSON() {
                (_, _, JSON, error) in
                if error == nil {
//                    var l = JSON(json!)["list"]
//                    for (i,_) in enumerate(l)
                    var list =  (JSON as? [NSObject: AnyObject])?["list"] as? [[NSObject: AnyObject]]
                    if let l = list {
                        for (i, _) in enumerate(l) {
                            let temp = l[i]["main"]?["temp"] as? Double ?? 0
                            var weatherDes =  l[i]["weather"] as? [[NSObject: AnyObject]]
                            self.currentData.append([
                                cForecast.kTemp: temp,
                                cForecast.kDesc: weatherDes?.first?["main"] as? String ?? "-",
                                //cForecast.kIDWeather: weatherDes?.first?["id"] as? Int
                                ])
                        }
                        self.tableView.reloadData()
                    }
                    
                } else {
                    weatherService.showAlertWithText("Can't determine weather.", sender: self)
                }
                
            }
        }
    }
    
    
    // MARK: - UITableView Protocols
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {                tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let u = User.getUser()
        if indexPath.row == 0 {
            u?.uChosenLocationID = cUser.ChosenLocationCurrent
            u?.uChosenLocationName = ""
            u?.uCurrentLatitude = 0
            u?.uCurrentLongitude = 0
            println("selected city: current")
        } else {
            u?.uChosenLocationName = data[indexPath.row - 1].sCityName
            u?.uChosenLocationID = data[indexPath.row - 1].sID
            println("selected city:\(data[indexPath.row - 1].sCityName)")
        }
        weatherService.saveContext()
        
        NSNotificationCenter.defaultCenter().postNotificationName(cGeneral.ChangeSelectedCity, object: self)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationCell") as! LocationCell
        
        if indexPath.row == 0 {
            
            let user = User.getUser()!
            if user.uChosenLocationID.integerValue == cUser.ChosenLocationCurrent {
                cell.iCity.text = user.uChosenLocationName
                cell.iTemp.text = "\(user.uCurrentTemperature)"
                cell.iCondition.text = user.uCurrentCondition
                cell.iCurrent.hidden = false
//                cell.iTemp.hidden = true
//                cell.iCity.text = "Current"
//                cell.iCondition.hidden = true
            } else {
                cell.iCity.text = "Current"
                //cell.iTemp.text = ""
                //cell.iCondition.text = ""
                cell.iTemp.hidden = true
                cell.iCondition.hidden = true
            }
        
        } else {
            cell.iCurrent.hidden = true
            cell.iCity.text = data[indexPath.row - 1].sCityName
            if SavedCity.getAllCities()?.count == currentData.count {
                let temp = currentData[indexPath.row - 1][cForecast.kTemp] as! Double
                cell.iTemp.text = "\(temp)"
                cell.iCondition.text = currentData[indexPath.row - 1][cForecast.kDesc] as? String
            } else {
                cell.iTemp.text = "xxx"
                cell.iCondition.text = "xxx"
            }
        }
        
        return cell
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            SavedCity.removeCity(self.data[indexPath.row - 1])
            self.data.removeAtIndex(indexPath.row - 1)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        return [deleteAction]
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            println("Delete one")
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }

}