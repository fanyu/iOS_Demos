//
//  ViewControllerExtension.swift
//  Godness
//
//  Created by FanYu on 1/3/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit
extension ViewController:UIPickerViewDataSource
{
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 5
    }

}

extension ViewController:UIPickerViewDelegate
{
    func pickerView(pickeºrView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return beauties[row]
    }
}