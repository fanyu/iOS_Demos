//
//  ViewController.swift
//  RedHeart
//
//  Created by FanYu on 16/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let heartView = HeartView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        //heartView.center = self.view.center
        
        self.view.addSubview(heartView)
     
        let a = Array(0.stride(to: 10, by: 2))
        print("A \(a)")
        
        // Map
        let a1 = [1, 2, 3, 4, 5, 6]
        
        print(a1.map({ (num) -> Int in
            return num * 2
        }))
        
        print(a1.map({ (num) in
            return num * 2
        }))
        
        print(a1.map({ num in
            num * 2
        }))
        
        print(a1.map({$0 * 2}))
        
        
        let fruits = ["apple", "banana", "orange"]
        let counts = fruits.map { (fruit) -> Int? in
            let length = fruit.characters.count
            guard length > 0 else {
                return nil
            }
            return length
        }
        print(counts)
        
        
        let array = [1, 2, 3, 4, 5, 6]
        let isEven = array.map {
            $0 % 2 == 0
        }
        print(isEven)
        
        
        // FlatMap 
        let fruits2 = ["apple", "banana", "orange", ""]
        let counts2 = fruits2.flatMap { (fruit) -> Int? in
            let length = fruit.characters.count
            guard length > 0 else {
                return nil
            }
            return length
        }
        print(counts2)
        
        
        let array1 = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        let arrayFlatMap = array1.flatMap({$0})
        print(arrayFlatMap)
        
        
        let fruits3 = ["apple", "banana", "orange"]
        let counts3 = [1, 2, 3]
        let fruitCounts = counts3.flatMap { (count) in
            fruits3.map({ (fruit) in
                (fruit, count)
            })
        }
        print(fruitCounts)
        
        
        // filter 
        let nums = [1,2,3,4,5,6]
        let evens = nums.filter {
            $0 % 2 == 0
        }
        print(evens)
        
        
        // reduce 
        let nums2 = [1,2,3,4,5]
        let sum2 = nums2.reduce(0) { $0 + $1 }
        print(sum2)
        
        let nums3 = [1,3,6,1,3,5,1,2,1,9,9]
        let tel3 = nums3.reduce("") { "\($0)" + "\($1)" }
        print(tel3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

