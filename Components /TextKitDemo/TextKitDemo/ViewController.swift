//
//  ViewController.swift
//  TextKitDemo
//
//  Created by FanYu on 6/20/16.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        makeUI()
        make2()
        make3()
        leffterpressEffect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension ViewController {
    
    // 使用NSAttributedString实现简单的文字高亮
    private func makeUI() {
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: 0, length: 20))
        textView.attributedText = attributedString
        
        
    }

    // 使用Text Storage实现文字高亮
    private func make2() {
        
        let frame = CGRect(x: 0, y: 20, width: 300, height: 150)
        
        let textStorage = NSTextStorage()
        
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: frame.size)
        layoutManager.addTextContainer(textContainer)
        
        let textView2 = UITextView(frame: frame, textContainer: textContainer)
        
        let textString = textView.text
        textView2.textStorage.replaceCharactersInRange(NSRange(location: 0,length: 0), withString: textString)
        
        view.addSubview(textView2)
        
        textView2.textStorage.beginEditing()
        let attributesDict = [NSForegroundColorAttributeName : UIColor.blueColor()]
        textView2.textStorage.setAttributes(attributesDict, range: NSRange(location: 0, length: 40))
        textView2.textStorage.endEditing()
    }
    
    // 文本元素与非文本元素混排
    private func make3() {
        let circleView = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        circleView.layer.cornerRadius = 25
        circleView.backgroundColor = UIColor.orangeColor()
        textView.addSubview(circleView)
        
        // 把 textView 上的 circleView的 frame 从 CircleView 转换到 textView
        var circleFrame = textView.convertRect(circleView.bounds, fromView: circleView)
        circleFrame.origin.x = circleFrame.origin.x - textView.textContainerInset.left
        circleFrame.origin.y = circleFrame.origin.y - textView.textContainerInset.top
        let circlePath = UIBezierPath(roundedRect: circleFrame, cornerRadius: 50)
        
        
        let exclusionPath = UIBezierPath(arcCenter: circleView.center, radius: 40, startAngle: -180, endAngle: 180, clockwise: true)

        //textView.textContainer.exclusionPaths = [exclusionPath]
        textView.textContainer.exclusionPaths = [circlePath]
    }
    
    private func leffterpressEffect() {
        
        // Letterpress Effect
        let attributes = [ NSForegroundColorAttributeName   : UIColor.blueColor(),
                           NSFontAttributeName              : UIFont.boldSystemFontOfSize(17),
                           NSTextEffectAttributeName        : NSTextEffectLetterpressStyle
        ]
        let attributesStr = NSAttributedString(string: "Letterpress Effect", attributes: attributes)
        
        titleLabel.attributedText = attributesStr
    }
    
}

