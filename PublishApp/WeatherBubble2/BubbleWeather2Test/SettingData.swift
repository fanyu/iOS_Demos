//
//  SettingData.swift
//  BubbleWeather2Test
//
//  Created by FanYu on 7/30/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import Foundation


struct SectionData {
    let title: String
    let data : [String]
    
    init(title: String, data: String...) {
        self.title = title
        self.data  = data
    }

    var numberOfItems: Int {
        return data.count
    }
    
    subscript(index: Int) -> String {
        return data[index]
    }
}


