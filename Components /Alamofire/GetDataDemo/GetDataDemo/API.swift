//
//  API.swift
//  GetDataDemo
//
//  Created by FanYu on 24/3/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import Foundation

private let server = "http://192.168.1.120:8080" //

struct API {
    
    static let marketIntro = "\(server)/lotus/market/marketIntroduction.do?marketId=1"
    
    static let photo = "https://api.500px.com/v1/photos"
    static let key = "3k1zcQxFS4S7nOmTXzmH0nw3zBjOTuOIZ1hCbrgN"
}