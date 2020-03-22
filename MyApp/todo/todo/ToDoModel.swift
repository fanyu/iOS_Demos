//
//  ToDoModel.swift
//  todo
//
//  Created by FanYu on 2/17/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class TodoModel: NSObject
{
    var id: String
    var image: String
    var title: String
    var date: NSDate
    
    init(id: String, image: String, title: String, date: NSDate)
    {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}
