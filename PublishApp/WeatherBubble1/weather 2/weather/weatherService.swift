//
//  weatherConvert.swift
//  weather
//
//  Created by FanYu on 5/30/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

public enum Status {
    case success
    case failure
}

public class Response {
    public var status: Status?
    public var object: JSON?
    public var error: NSError?
}

public class weatherService {
    
    
    public func retrieveForecast(latitude: CLLocationDegrees, longtitude: CLLocationDegrees, success: (response: Response) ->(), failure: (response: Response) ->()) {
        let url = "http://api.openweathermap.org/data/2.5/forecast"
        let params = ["lat":latitude, "lon":longtitude]
        print(params)
        
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { (request, response, json, error) in
                if error != nil {
                    var response = Response()
                    response.status = .failure
                    response.error = error
                    failure(response: response)
                    
                    print("Error: \(error)")
                    print(request)
                    print(response)
                } else {
                    var json = JSON(json!)
                    var response = Response()
                    response.status = .success
                    response.object = json
                    success(response: response)
                    
                    print("Success: \(url)")
                }
        }
    }
    
    public func conditionJudge(condition: Int) ->(String, String){
        
        if condition < 300 {
            return ("雷阵雨", "等等呗")
        } else if condition < 500 {
            return ("毛毛雨", "漫步吧")
        } else if condition == 500 {
            return ("小雨", "看书吧")
        } else if condition == 501 {
            return ("中雨", "打伞哦")
        } else if condition == 502 {
            return ("大雨", "打伞哦")
        } else if condition <= 511 {
            return ("冻雨", "加衣服")
        } else if condition <= 531 {
            return ("阵雨", "等等呗")
        } else if condition == 600 {
            return ("小雪", "温馨啊")
        } else if condition == 601 {
            return ("中雪", "啤酒炸鸡")
        } else if condition == 602 {
            return ("大雪", "打雪仗")
        } else if condition < 620 {
            return ("雨夹雪", "打伞哦")
        } else if condition == 620 {
            return ("小阵雪", "无所谓")
        } else if condition == 621 {
            return ("中阵雪", "等等呗")
        } else if condition == 622 {
            return ("大阵雪", "等等呗")
        } else if condition == 701 {
            return ("薄雾", "迷离中")
        } else if condition < 741 {
            return ("雾霾", "带口罩")
        } else if condition == 741 {
            return ("大雾", "看路哦")
        } else if condition < 771 {
            return ("沙尘暴", "待家呗")
        } else if condition < 800 {
            return ("龙卷风", "要当心")
        } else if condition == 800 {
            return ("晴朗", "好天气")
        } else if condition < 804 {
            return ("少云", "墨镜呢")
        } else if condition == 804 {
            return ("多云", "挺凉快")
        } else if condition < 902 {
            return ("龙卷风", "待家呗")
        } else if condition == 902 {
            return ("飓风", "待家呗")
        } else if condition == 903 {
            return ("寒冷", "加衣哦")
        } else if condition == 904 {
            return ("炎热", "防中暑")
        } else if condition == 905 {
            return ("多风天", "墨镜呢")
        } else if condition == 906 {
            return ("冰雹", "当心啊")
        } else if condition == 951 {
            return ("无风", "不起浪")
        } else if condition <= 952 {
            return ("小风", "舒服啊")
        } else if condition == 953 {
            return ("微风", "惬意哦")
        } else if condition == 954 {
            return ("和风", "凉爽啊")
        } else if condition == 955 {
            return ("清风", "风略大")
        } else if condition < 958 {
            return ("强风", "待屋里")
        } else if condition <= 959 {
            return ("烈风", "待屋里")
        } else if condition == 960 {
            return ("暴风", "待屋里")
        } else if condition <= 962 {
            return ("飓风", "待屋里")
        } else {
            return ("什么鬼", "无乱用")
        }
    }
    
    func humidityJudge(humidity: Int) ->String {
        if humidity <= 20 {
            return "很干燥"
        } else if humidity <= 40 {
            return "较干燥"
        } else if humidity <= 50 {
            return "舒适啊"
        } else if humidity <= 70 {
            return "较潮湿"
        } else {
            return "很潮湿"
        }
    }
    
    func windJudge(windSpeed: Float) ->String {
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
    
    func pollutionJudge(pm2_5: Int) ->String {
        if pm2_5 < 50 {
            return "空气优"
        } else if pm2_5 < 100 {
            return "空气良"
        } else if pm2_5 < 150 {
            return "微污染"
        } else if pm2_5 < 200 {
            return "轻污染"
        } else if pm2_5 < 300 {
            return "中污染"
        } else {
            return "重污染"
        }
    }
    
    //    public func conditionJudge(condition: Int, index: Int, callback: (index: Int, name: String) ->()){
    //
    //        if condition < 300 {
    //            callback(index: index, name: "雷阵雨")
    //        } else if condition < 500 {
    //            callback(index: index, name: "毛毛雨")
    //        } else if condition == 500 {
    //            callback(index: index, name: "小雨")
    //        } else if condition == 501 {
    //            callback(index: index, name: "中雨")
    //        } else if condition == 502 {
    //            callback(index: index, name: "大雨")
    //        } else if condition <= 511 {
    //            callback(index: index, name: "冻雨")
    //        } else if condition <= 531 {
    //            callback(index: index, name: "阵雨")
    //        } else if condition == 600 {
    //            callback(index: index, name: "小雪")
    //        } else if condition == 601 {
    //            callback(index: index, name: "中雪")
    //        } else if condition == 602 {
    //            callback(index: index, name: "大雪")
    //        } else if condition < 620 {
    //            callback(index: index, name: "雨夹雪")
    //        } else if condition == 620 {
    //            callback(index: index, name: "小阵雪")
    //        } else if condition == 621 {
    //            callback(index: index, name: "中阵雪")
    //        } else if condition == 622 {
    //            callback(index: index, name: "大阵雪")
    //        } else if condition == 701 {
    //            callback(index: index, name: "薄雾")
    //        } else if condition < 741 {
    //            callback(index: index, name: "雾霾")
    //        } else if condition == 741 {
    //            callback(index: index, name: "大雾")
    //        } else if condition < 771 {
    //            callback(index: index, name: "沙尘暴")
    //        } else if condition < 800 {
    //            callback(index: index, name: "龙卷风")
    //        } else if condition == 800 {
    //            callback(index: index, name: "晴朗")
    //        } else if condition < 804 {
    //            callback(index: index, name: "少云")
    //        } else if condition == 804 {
    //            callback(index: index, name: "多云")
    //        } else if condition < 902 {
    //            callback(index: index, name: "龙卷风")
    //        } else if condition == 902 {
    //            callback(index: index, name: "飓风")
    //        } else if condition == 903 {
    //            callback(index: index, name: "寒冷")
    //        } else if condition == 904 {
    //            callback(index: index, name: "炎热")
    //        } else if condition == 905 {
    //            callback(index: index, name: "多风天")
    //        } else if condition == 906 {
    //            callback(index: index, name: "冰雹")
    //        } else if condition == 951 {
    //            callback(index: index, name: "无风")
    //        } else if condition <= 952 {
    //            callback(index: index, name: "小风")
    //        } else if condition == 953 {
    //            callback(index: index, name: "微风")
    //        } else if condition == 954 {
    //            callback(index: index, name: "和风")
    //        } else if condition == 955 {
    //            callback(index: index, name: "清风")
    //        } else if condition < 958 {
    //            callback(index: index, name: "强风")
    //        } else if condition <= 959 {
    //            callback(index: index, name: "烈风")
    //        } else if condition == 960 {
    //            callback(index: index, name: "暴风")
    //        } else if condition <= 962 {
    //            callback(index: index, name: "飓风")
    //        } else {
    //            callback(index: index, name: "什么鬼")
    //        }
    //    }
    
    
    
    public func convertTemperature(country: String, temperature: Double) ->(Double, String) {
        var str = ""
        var temp: Double = 0
        if country == "US" {
            temp = round(((temperature - 273.5) * 1.8) + 32)
        } else {
            temp = round(temperature - 273.5)
        }
        
        if temp < -20 {
            str = "极其冷"
        } else if temp < -10 {
            str = "非常冷"
        } else if temp < 0 {
            str = "结冰啦"
        } else if temp < 10 {
            str = "降温了"
        } else if temp < 20 {
            str = "舒适哦"
        } else if temp < 30 {
            str = "有点热"
        } else if temp < 35 {
            str = "非常热"
        } else if temp < 40{
            str = "热死啦"
        } else {
            str = "已热死"
        }
        
        
        return (temp, str)
    }
}