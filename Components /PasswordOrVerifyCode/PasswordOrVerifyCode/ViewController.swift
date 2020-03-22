//
//  ViewController.swift
//  PasswordOrVerifyCode
//
//  Created by FanYu on 19/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: [UITextField]!
    @IBOutlet weak var securityButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var securityInputFlag:Bool = true
    var password: String = ""
    
    @IBAction func editingChanged(sender: UITextField) {
        
        password += sender.text!
        
        switch sender.tag {
            
        case 1 : sender.resignFirstResponder()
                 textField[2].becomeFirstResponder()
            
        case 2 : textField[2].resignFirstResponder()
                 textField[3].becomeFirstResponder()
            
        case 3 : textField[3].resignFirstResponder()
                 textField[0].becomeFirstResponder()
            
        case 4 : textField[0].resignFirstResponder()
                 submitButton.backgroundColor = UIColor.blueColor()
            
        default : break
        }

        
    }
    
    
    @IBAction func cancleButtonTapped(sender: UIButton) {
        for field in textField {
            field.text = ""
            textField[1].becomeFirstResponder()
        }
    }
    
    @IBAction func submitButtonTapped(sender: UIButton) {
        
    }
    
    
    @IBAction func securityButtonTapped(sender: UIButton) {
        if securityInputFlag {
            sender.setImage(UIImage(named: "Glasses"), forState: .Normal)
            for field in textField {
                field.secureTextEntry = false
            }
            securityInputFlag = false
        } else {
            sender.setImage(UIImage(named: "Glasses Filled-32"), forState: .Normal)
            for field in textField {
                field.secureTextEntry = true
            }
            securityInputFlag = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        layoutView()
        self.title = "Cursor"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController {
    
    func layoutView() {
        // textfield 
        for field in textField {
            field.layer.borderColor = UIColor.lightGrayColor().CGColor
            field.layer.borderWidth = 0.6
            field.secureTextEntry = true
            field.keyboardType = .NumberPad
            field.font = UIFont.boldSystemFontOfSize(20)
        }
        
        textField[1].becomeFirstResponder()
        securityInputFlag = true
    }
    
}

