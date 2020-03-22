//
//  DetailViewController.swift
//  todo
//
//  Created by FanYu on 2/23/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var planeButton: UIButton!
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!
    
    var todo: TodoModel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        todoItem.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtons()
    {
        childButton.selected = false
        phoneButton.selected = false
        shoppingButton.selected = false
        planeButton.selected = false
    }
    @IBAction func childTapped(sender: AnyObject)
    {
        resetButtons()
        childButton.selected = true
    }
    
    @IBAction func phoneTapped(sender: AnyObject)
    {
        resetButtons()
        phoneButton.selected = true
    }
    
    @IBAction func shoppingTapped(sender: AnyObject)
    {
        resetButtons()
        shoppingButton.selected = true
    }
    
    @IBAction func planeTapped(sender: AnyObject)
    {
        resetButtons()
        planeButton.selected = true
    }
    
    @IBAction func submitTapped(sender: AnyObject)
    {
        var image = ""
        if childButton.selected
        {
            image = "child-selected"
        }
        else if phoneButton.selected
        {
            image = "phone-selected"
        }
        else if shoppingButton.selected
        {
            image = "shopping-card-selected"
        }
        else
        {
            image = "travel-selected"
        }
        
        let uuid = NSUUID().UUIDString
        var todo = TodoModel(id: uuid, image: image, title: todoItem.text, date: todoDate.date)
        todos.append(todo)
    }

    //hide keyboard when touch return
    func textFieldShouldReturn(textField: UITextField) ->Bool
    {
        textField.resignFirstResponder()
        return true
    }
    //hide keyboard when touch otherplace
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        todoItem.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
