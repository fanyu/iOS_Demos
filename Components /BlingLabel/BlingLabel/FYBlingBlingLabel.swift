//
//  FYBlingBlingLabel.swift
//  BlingLabel
//
//  Created by FanYu on 6/21/16.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class FYBlingBlingLabel: UILabel {

    var appearDuration = 1.5
    var disappearDuration = 1.5
    var attributedString: NSMutableAttributedString?
    var needAnimation = false
    
    private var displayLink: CADisplayLink?
    private var isAppearing = false
    private var isDisappearing = false
    private var isDisappearingForChangeText = false
    private var beginTime: CFTimeInterval?
    private var endTiem: CFTimeInterval?
    private var durationArray: NSMutableArray?
    private var newString: NSString?
    
    override var text: String? {
        get {
            if needAnimation {
                return self.attributedString?.string
            } else {
                return super.text
            }
        }
        set {
            if needAnimation {
                self.convertToAttributedString(newValue!)
            } else {
                super.text = newValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        displayLink = CADisplayLink(target: self, selector: #selector(FYBlingBlingLabel.updateAttributedString))
        displayLink?.paused = true
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension FYBlingBlingLabel {
    
    // 刷新文字
    @objc private func updateAttributedString() {
        
        // 动画已经进行的时间
        let pastDuration = CACurrentMediaTime() - beginTime!
        
        // 正在进行显示文字动画
        if isAppearing {
            // 如果已进行的时间大于动画时间 则暂停
            if pastDuration > appearDuration {
                displayLink?.paused = true  // 暂停刷新
                isAppearing = false         // 修改标志位
                return
            }
            
            // 对每个文字进行属性修改
            for i in 0 ..< attributedString!.length {
                // 获取进度
                var progress = CGFloat((pastDuration - (durationArray![i] as! Double)) / (appearDuration * 0.5))
                progress = max(0, min(1, progress))
                
                // 获取文字的 alpha 根据进度
                let color = self.textColor.colorWithAlphaComponent(progress)
                // 给当前的 一个文字 修改属性
                attributedString?.addAttributes([NSForegroundColorAttributeName: color], range: NSMakeRange(i, 1))
            }
        }
        
        // 正在进行消失文字动画
        if isDisappearing {
            // 如果已执行完消失动画时间
            if pastDuration > disappearDuration {
                displayLink?.paused = true  // 停止刷新
                isDisappearing = false      // 修改标志位
                
                // 由于赋值了 新的文字而进行消失动画结束
                if isDisappearingForChangeText {
                    isDisappearingForChangeText = false
                    self.appear()   // 新的文字进行显示
                }
                return
            }
            
            // 改变每个文字的属性
            for i in 0 ..< attributedString!.length {
                var progress:CGFloat = CGFloat((pastDuration - (durationArray![i] as! Double))/(disappearDuration * 0.5))
                progress = max(0, min(1, progress))

                let color = self.textColor.colorWithAlphaComponent(1 - progress)
                attributedString?.addAttributes([NSForegroundColorAttributeName: color], range: NSMakeRange(i, 1))
            }
        }
        
        // 更新新的一套有属性的文字
        attributedText = attributedString
    }
    
    // 转为属性字体
    private func convertToAttributedString(text: String) {
        // 保存新的文字
        newString = text
        
        // 已经进行过显示动画
        if self.attributedText?.length > 0 {
            // 已经显示过的文字进行消失动画  由于切换新的文字
            disappear()
            isDisappearingForChangeText = true
        } else {
            appear()
        }
    }
    
    // 产生随机的时间数组
    private func initDurationArray(duration: Double) {
        durationArray = NSMutableArray(array: [])
        // 根据属性字体的数目 生成 每个字对应的 时间
        for _ in 0 ..< attributedString!.length {
            let progress: CGFloat = CGFloat(arc4random_uniform(100))/100.0
            durationArray?.addObject(progress * CGFloat(duration) * 0.5)
        }
    }
    
    // 出现
    private func appear() {
        attributedString = NSMutableAttributedString(string: newString as! String)
        isAppearing = true
        beginTime   = CACurrentMediaTime()
        endTiem     = CACurrentMediaTime() + appearDuration
        displayLink?.paused = false
        initDurationArray(appearDuration)
    }
    
    // 消失
    private func disappear() {
        isDisappearing = true
        beginTime = CACurrentMediaTime()
        endTiem = CACurrentMediaTime() + disappearDuration
        displayLink?.paused = false
        initDurationArray(disappearDuration)
    }
 
}
