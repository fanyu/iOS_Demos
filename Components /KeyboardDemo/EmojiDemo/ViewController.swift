//
//  ViewController.swift
//  EmojiDemo
//
//  Created by FanYu on 3/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var width: CGFloat { return UIScreen.mainScreen().bounds.size.width }
    private var height: CGFloat { return UIScreen.mainScreen().bounds.size.height }
    
    // content view 
    private var contentView: UIView!
    
    // toolbar
    private var edcButtonView: EDCButtonView!
    
    // collection 
    private var emojiCollectionView: UICollectionView!
    private var cellType: String!
    
    // keyboard view
    private let keyboardView = UIView()
    
    // input 
    var enterView: InputFieldView!
    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // keyboard notifcation
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}


extension ViewController {
    func setup() {
        // content
        self.contentView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.contentView.backgroundColor = UIColor(red:0.4, green:0.8, blue:1, alpha:1)
        self.view.addSubview(self.contentView)
        
        self.view.addSubview(self.textField)
        
        // enter field 
        enterView = InputFieldView(frame: CGRect(x: 0, y: 300, width: width, height: 44))
        enterView.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        self.contentView.addSubview(enterView)
        
        
        // keyboard view
        keyboardView.frame = CGRect(x: 0, y: height - 250, width: width, height: 250)
        keyboardView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(keyboardView)
        
        // button view
        edcButtonView = EDCButtonView(frame: CGRect(x: 0, y: 0, width: width, height: 44), keyboardView: self.contentView, textField: self.textField)
        self.keyboardView.addSubview(edcButtonView)
        edcButtonView.imageButton.addTarget(self, action: "imageButtonTapped", forControlEvents: .TouchUpInside)
        edcButtonView.atButton.addTarget(self, action: "atButtonTapped", forControlEvents: .TouchUpInside)
        edcButtonView.numberButton.addTarget(self, action: "numberButtonTapped", forControlEvents: .TouchUpInside)
        edcButtonView.emojiButton.addTarget(self, action: "emojiButtonTapped", forControlEvents: .TouchUpInside)
        edcButtonView.plusButton.addTarget(self, action: "plusButtonTapped", forControlEvents: .TouchUpInside)

        
        // collection view 
        emojiCollectionView = UICollectionView(frame: CGRect(x: 0, y: 44, width: width, height: 250 - 44), collectionViewLayout: EmojiFlowLayout())
        emojiCollectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        emojiCollectionView.backgroundColor = UIColor.whiteColor()
        emojiCollectionView.dataSource = self
        emojiCollectionView.delegate = self
        emojiCollectionView.registerClass(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "EmojiCell")
        self.keyboardView.addSubview(emojiCollectionView)
        cellType = "emoji"
        
        //print(emojiCollectionView.contentOffset)
        
        // text field 
        textField.delegate = self
    }
}

// MARK: - UICollection View
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EmojiCell", forIndexPath: indexPath) as! EmojiCollectionViewCell
        
        switch cellType {
        case "emoji" :
            cell.label.text = "\(indexPath.row)"
            cell.imageView.backgroundColor = UIColor.whiteColor()
        
        case "#" :
            cell.label.text = "#"
            cell.imageView.backgroundColor = UIColor.yellowColor()
            
        case "@" :
            cell.label.text = "@"
            cell.imageView.backgroundColor = UIColor.purpleColor()
            
        case "face" :
            cell.label.text = "*"
            cell.imageView.backgroundColor = UIColor.orangeColor()
            
        default: break
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //print(indexPath.row)
    }
    
}

//MARK: - Button handle
extension ViewController {
    func imageButtonTapped() {
        print("image")
        cellType = "emoji"
        refresh()
    }
    
    func atButtonTapped() {
        print("@")
        cellType = "@"
        refresh()
    }
    
    func numberButtonTapped() {
        print("#")
        cellType = "#"
        refresh()
    }
    
    func emojiButtonTapped() {
        print("face")
        cellType = "face"
        refresh()
    }
    
    func plusButtonTapped() {
        print("plus")
        self.textField.becomeFirstResponder()
    }
    
    func refresh() {
        UIView.animateWithDuration(0.3) { () -> Void in
            // hide keyboard first
            self.textField.resignFirstResponder()
            self.keyboardView.frame.origin.y = self.height - 250
        }
        emojiCollectionView.contentOffset = CGPoint(x: -5, y: -5)
        emojiCollectionView.reloadData()
    }

}


// MARK: - Keyboard Notification
// 在keyboard监听里面改变 Y 这样可以使得view的变化跟随keyboard实时变化
extension ViewController {
    // show
    func keyboardWillAppear(notification: NSNotification) {
        guard let keyboardInfo = notification.userInfo else { return }
        let keyboardHeight = keyboardInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size.height
        
        self.keyboardView.frame.origin.y = height - keyboardHeight! - 44
        //print(111111)
    }
    
    // hide
    func keyboardWillHide(notification: NSNotification) {
        self.keyboardView.frame.origin.y = height - 44
    }
}


// MARK: - TextField 
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
}
