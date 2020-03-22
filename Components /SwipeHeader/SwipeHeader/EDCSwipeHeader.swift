//
//  edcSwipe.swift
//  SwipeHeader
//
//  Created by FanYu on 10/13/15.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

//MARK: - Set Corner Radius
class EDCSwipeRoundCornerLayer: CALayer {
    override var frame: CGRect {
        didSet { cornerRadius = bounds.height / 2 }
    }
}

class EDCSwipeHeader: UIControl {
    
    // MARK: - Variable
    private var leftTitleLabel = UILabel()
    private var rightTitleLabel = UILabel()
    private var titleLabelContentView = UIView()
    
    private var selectedLeftTitleLabel = UILabel()
    private var selectedRightTitleLabel = UILabel()
    private var selectedTitleLabelContentView = UIView()
    
    private(set) var selectedBackgroundView = UIView()
    private var titleMaskView = UIView()
    
    private var initialSelectedBackgroundViewFrame: CGRect?
    private var selectedIndex: Int = 0

    private var tapGesture: UITapGestureRecognizer!
    private var panGesture: UIPanGestureRecognizer!
    
    var animationDuration: NSTimeInterval = 0.3
    var animationSpringDamping: CGFloat = 0.75  //弹簧阻尼
    var animationInitialSpringVelocity: CGFloat = 0.0   //初始弹簧速度
    
    var leftTitle: String {
        set { (leftTitleLabel.text, selectedLeftTitleLabel.text) = (newValue, newValue)}
        get { return leftTitleLabel.text! }
    }
    
    var rightTitle: String {
        set { (rightTitleLabel.text, selectedRightTitleLabel.text) = (newValue, newValue)}
        get { return rightTitleLabel.text! }
    }
    
    var selectedBackgroundInset: CGFloat = 2.0 {
        didSet { setNeedsLayout() }
    }
    
    var selectedBackgroundViewColor: UIColor! {
        get { return selectedBackgroundView.backgroundColor }
        set { selectedBackgroundView.backgroundColor = newValue }
    }
    
    var titleColor: UIColor! {
        set { (leftTitleLabel.textColor, rightTitleLabel.textColor) = (newValue, newValue) }
        get { return leftTitleLabel.textColor }
    }
    
    var selectedTitleColor: UIColor! {
        set { (selectedLeftTitleLabel.textColor, selectedRightTitleLabel.textColor) = (newValue, newValue) }
        get { return selectedLeftTitleLabel.textColor }
    }
    
    var titleFont: UIFont! {
        set { (leftTitleLabel.font, rightTitleLabel.font, selectedLeftTitleLabel.font, selectedRightTitleLabel.font) = (newValue, newValue, newValue, newValue) }
        get { return leftTitleLabel.font }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(leftTitle: String, rightTitle: String) {
        super.init(frame: CGRectZero)
        
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutFrame()
    }

    override class func layerClass() -> AnyClass {
        return EDCSwipeRoundCornerLayer.self
    }
    
    deinit {
        removeObserver(self, forKeyPath: "selectedBackgroundView.frame")
    }
}


//MARK: - Layout Frame
extension EDCSwipeHeader {
    private func layoutFrame() {
        
        // bottom lable view
        addSubview(titleLabelContentView)
        titleLabelContentView.addSubview(leftTitleLabel)
        titleLabelContentView.addSubview(rightTitleLabel)
        
        // selected view
        object_setClass(selectedBackgroundView.layer, EDCSwipeRoundCornerLayer.self)
        addSubview(selectedBackgroundView)
        
        // selected lable view
        addSubview(selectedTitleLabelContentView)
        selectedTitleLabelContentView.addSubview(selectedLeftTitleLabel)
        selectedTitleLabelContentView.addSubview(selectedRightTitleLabel)
        
        // text alignment
        (leftTitleLabel.textAlignment, rightTitleLabel.textAlignment, selectedLeftTitleLabel.textAlignment, selectedRightTitleLabel.textAlignment) = (.Center, .Center, .Center, .Center)
        
        // mask view
        object_setClass(titleMaskView.layer, EDCSwipeRoundCornerLayer.self)
        titleMaskView.backgroundColor = UIColor.blackColor()
        selectedTitleLabelContentView.maskView = titleMaskView
        
        // set default color
        backgroundColor = UIColor.blackColor()
        selectedBackgroundViewColor = UIColor.whiteColor()
        titleColor = UIColor.whiteColor()
        selectedTitleColor = UIColor.blackColor()
        
        tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        addGestureRecognizer(tapGesture)
        
        panGesture = UIPanGestureRecognizer(target: self, action: "pan:")
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
        
        addObserver(self, forKeyPath: "selectedBackgroundView.frame", options: .New, context: nil)
    }
}

//MARK: - Observer
extension EDCSwipeHeader {
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "selectedBackgroundView.frame" {
            titleMaskView.frame = selectedBackgroundView.frame
        }
    }
}


//MARK: - Helper
extension EDCSwipeHeader {
    func setSelectedIndex(selectedIndex: Int, animated: Bool) {
        self.selectedIndex = selectedIndex
        
        if animated {
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: animationSpringDamping, initialSpringVelocity: animationInitialSpringVelocity, options: [UIViewAnimationOptions.BeginFromCurrentState, UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                    self.layoutSubviews()
                }, completion: { (finished) -> Void in
                    if finished {
                        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
                    }
            })
        }
        else {
            self.layoutSubviews()
            self.sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    func tapped(sender: UITapGestureRecognizer) {
        let location = sender.locationInView(self)
        if location.x < bounds.width / 2{
            setSelectedIndex(0, animated: true)
        } else {
            setSelectedIndex(1, animated: true)
        }
    }
    
    func pan(sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            initialSelectedBackgroundViewFrame = selectedBackgroundView.frame
        } else if sender.state == UIGestureRecognizerState.Changed {
            var frame = initialSelectedBackgroundViewFrame!
            frame.origin.x += sender.translationInView(self).x
            frame.origin.x = max(min(frame.origin.x, bounds.width - selectedBackgroundInset - frame.width), selectedBackgroundInset) // 大于左边界inset  小于右边界
            selectedBackgroundView.frame = frame
        } else if sender.state == .Ended || sender.state == .Failed || sender.state == .Cancelled {
            let velocityX = sender.velocityInView(self).x
            
            if velocityX > 500.0 {          // 速度大 右侧
                setSelectedIndex(1, animated: true)
            } else if velocityX < -500.0 {  // 速度小 左侧
                setSelectedIndex(0, animated: true)
            } else if selectedBackgroundView.center.x >= bounds.width / 2.0 {
                setSelectedIndex(1, animated: true) // 大于一半 右侧
            } else if selectedBackgroundView.center.x < bounds.size.width / 2.0 {  // 小于一半 左侧
                setSelectedIndex(0, animated: true)
            }
        }
        titleMaskView.frame = selectedBackgroundView.frame
    }
    
    
    //MARK: - Override Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // set lable,selectedlabel,selectedBackground 's frame
        let selectedBackgroundWidth = bounds.width / 2.0 - selectedBackgroundInset * 2.0
        selectedBackgroundView.frame = CGRect(x: selectedBackgroundInset + CGFloat(selectedIndex) * (selectedBackgroundWidth + selectedBackgroundInset * 2.0), y: selectedBackgroundInset, width: selectedBackgroundWidth, height: bounds.height - selectedBackgroundInset * 2.0)
        
        (titleLabelContentView.frame, selectedTitleLabelContentView.frame) = (bounds, bounds)
        
        let titleLabelMaxWidth = bounds.width / 2.0 - selectedBackgroundInset * 2.0
        let titleLabelMaxHeight = bounds.height - selectedBackgroundInset * 2.0
        
        let leftTitleLabelSize = leftTitleLabel.sizeThatFits(CGSize(width: titleLabelMaxWidth, height: titleLabelMaxHeight))
        let leftTitleLabelOrigin = CGPoint(x: floor((bounds.width / 2.0 - leftTitleLabelSize.width) / 2.0), y: floor((bounds.height - leftTitleLabelSize.height) / 2.0))
        let leftTitleLabelFrame = CGRect(origin: leftTitleLabelOrigin, size: leftTitleLabelSize)
        (leftTitleLabel.frame, selectedLeftTitleLabel.frame) = (leftTitleLabelFrame, leftTitleLabelFrame)
        
        let rightTitleLabelSize = rightTitleLabel.sizeThatFits(CGSize(width: titleLabelMaxWidth, height: titleLabelMaxHeight))
        let rightTitleLabelOrigin = CGPoint(x: floor(bounds.size.width / 2.0 + (bounds.width / 2.0 - rightTitleLabelSize.width) / 2.0), y: floor((bounds.height - rightTitleLabelSize.height) / 2.0))
        let rightTitleLabelFrame = CGRect(origin: rightTitleLabelOrigin, size: rightTitleLabelSize)
        (rightTitleLabel.frame, selectedRightTitleLabel.frame) = (rightTitleLabelFrame, rightTitleLabelFrame)
    }

}



// MARK: - Gesture Delegate
extension EDCSwipeHeader: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture {
            return selectedBackgroundView.frame.contains(gestureRecognizer.locationInView(self))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}




