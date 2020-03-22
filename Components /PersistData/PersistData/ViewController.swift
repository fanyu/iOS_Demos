//
//  ViewController.swift
//  PersistData
//
//  Created by FanYu on 16/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var meals = [Meal]()
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let meal1 = Meal(name: "1", photo: nil, rating: 1)!
        let meal2 = Meal(name: "2", photo: nil, rating: 2)!
        let meal3 = Meal(name: "3", photo: nil, rating: 3)!
        
        meals += [meal1, meal2, meal3]
        
        Meal.saveMeals(meals)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("delaySeconds"), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func delaySeconds() {
        var meals = Meal.retrieveMeals()
        print("\(NSDate()) count: \(meals.count) \(meals[1].rating)")
        
        meals.removeAtIndex(2)
        
        print("No saved: \(Meal.retrieveMeals().count)")
        
        Meal.saveMeals(meals)
        print("saved: \(Meal.retrieveMeals().count)")
    }
}

