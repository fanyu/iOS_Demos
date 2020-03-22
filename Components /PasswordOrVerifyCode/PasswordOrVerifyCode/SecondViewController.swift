//
//  SecondViewController.swift
//  PasswordOrVerifyCode
//
//  Created by FanYu on 19/10/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var textField: [UITextField]!
    @IBOutlet weak var inputField: UITextField!
    
    var securityInputFlag:Bool = true
    var password: String = ""
    
    
    @IBAction func editingChanged(sender: UITextField) {
        let password: NSString = sender.text!
        
        if password.length == 4 {
            sender.resignFirstResponder()
        }
        
        switch password.length {
        case 1 : textField[0].text = password.substringWithRange(NSRange.init(location: 0, length: 1))
        case 2 : textField[1].text = password.substringWithRange(NSRange.init(location: 1, length: 1))
        case 3 : textField[3].text = password.substringWithRange(NSRange.init(location: 2, length: 1))
        case 4 : textField[2].text = password.substringWithRange(NSRange.init(location: 3, length: 1))
        default : break
        }
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
    
    
    @IBAction func cancleButtonTapped(sender: UIButton) {
        for field in textField {
            field.text = ""
        }
        inputField.text = ""
        inputField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initPasswordContentView()
        self.title = "No Cursor"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SecondViewController {
    func initPasswordContentView() {
        for field in textField {
            field.layer.borderColor = UIColor.lightGrayColor().CGColor
            field.layer.borderWidth = 0.6
            field.secureTextEntry = true
            field.keyboardType = .NumberPad
            field.userInteractionEnabled = false
            field.font = UIFont.boldSystemFontOfSize(20)
        }
        
        //textField[1].becomeFirstResponder()
        securityInputFlag = true

        inputField.becomeFirstResponder()
        inputField.keyboardType = .NumberPad
        inputField.hidden = true
    }
}
