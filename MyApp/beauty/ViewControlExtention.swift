//
//  ViewControlExtention.swift
//  beauty
//
//  Created by FanYu on 1/6/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

extension ViewController: UIPickerViewDataSource
{
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 3
    }
}

extension ViewController:UIPickerViewDelegate
{
    //returns the name which is displaied on the pickerview
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return Beauties[row]
    }
}