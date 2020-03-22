//
//  ViewController.swift
//  ChatDemo
//
//  Created by FanYu on 7/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var width: CGFloat { return UIScreen.main.bounds.size.width }
    var height: CGFloat { return UIScreen.main.bounds.size.height }
    
    @IBOutlet weak var tableView: UITableView!
    
    var cell: ChatTableViewCell!
    var cash: NSCache<AnyObject, AnyObject>!
    var chatText = ChatData().wordsArray
    var inputTextView: InputFieldView!
    var lastContentOffset: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // add gesture recognizer 
    override func viewDidAppear(_ animated: Bool) {
        
        // self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "viewTapped:"))
        
        // cell
        cell.textView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapTextView:"))
        
        // input view 
        inputTextView.leftButton.addTarget(self, action: "leftButtonTapped", for: .touchUpInside)
        inputTextView.rightPlusButton.addTarget(self, action: "rightPlusButtonTapped", for: .touchUpInside)
        inputTextView.rightEmojiButton.addTarget(self, action: "rightEmojiButtonTapped", for: .touchUpInside)
    }
    
    
    func setup() {
        
        // table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        //tableView.userInteractionEnabled = false
        
        // input view 
        inputTextView = InputFieldView(frame: CGRect(x: 0, y: height - 44, width: width, height: 44))
        self.view.addSubview(inputTextView)
        
        // cell
        cell = ChatTableViewCell()
    }
    
    
}






