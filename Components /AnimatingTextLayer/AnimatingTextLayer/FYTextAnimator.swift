//
//  FYTextAnimator.swift
//  AnimatingTextLayer
//
//  Created by FanYu on 6/22/16.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

@objc public protocol FYTextAnimatorDelegate {
    optional func textAnimationDidStart()
    optional func textAnimationDidStop()
}



public class FYTextAnimator: NSObject {

    public var fontName = "Avenir"
    public var fontSize: CGFloat = 50
    public var textToAnimate = "Hello World"
    public var textFillColor = UIColor.clearColor().CGColor//UIColor.redColor().CGColor
    
    public var delegate: FYTextAnimatorDelegate?
    
    private var animationLayer = CALayer()
    private var pathLayer = CAShapeLayer()
    private var referenceView = UIView()
    
    
    init(referenceView: UIView) {
        super.init()
        self.referenceView = referenceView
        makeUI()
    }
    
    deinit {
        pathLayer.removeFromSuperlayer()
    }
    
    private func makeUI() {
        animationLayer.frame = referenceView.bounds
        referenceView.layer.addSublayer(animationLayer)
        
        setupPathLayerWithText(textToAnimate, fontName: fontName, fontSize: fontSize)
    }
    
    // 将文字转化为路径
    private func setupPathLayerWithText(text: String, fontName: String, fontSize: CGFloat) {
        pathLayer.removeFromSuperlayer()
        
        // 可变图形路径
        let letters = CGPathCreateMutable()
        // 根据名字大小 获取字体
        let font = CTFontCreateWithName(fontName, fontSize, nil)
        // 根据字体 设置文字属性
        let attrString = NSAttributedString(string: text, attributes: [kCTFontAttributeName as String : font])
        // 根据属性文字 创建一个不可变的线性对象
        let line = CTLineCreateWithAttributedString(attrString)
        // 根据线性对象 获取GlypRuns(字形绘制的最小单元)
        let runArray = CTLineGetGlyphRuns(line)
        
        // 对每个文字的字形 进行路径获取
        for runIndex in 0 ..< CFArrayGetCount(runArray) {
            // 将一个指针强制按位转换成所需类型的对象Run
            let run = unsafeBitCast(CFArrayGetValueAtIndex(runArray, runIndex), CTRunRef.self)
            // 将 Run 转换为 CFDictionary
            let dict = unsafeBitCast(CTRunGetAttributes(run), CFDictionaryRef.self) as NSDictionary
            let runFont = dict[kCTFontAttributeName as String] as! CTFont
            
            // 获取CTRun(既字形绘制的最小单元）的路径
            for runGlyphIndex in 0 ..< CTRunGetGlyphCount(run) {
                let thisGlyphRange = CFRange(location: runGlyphIndex, length: 1)
                var glyph = CGGlyph()
                var position = CGPointZero
                // 复制当前index的字形
                CTRunGetGlyphs(run, thisGlyphRange, &glyph)
                // 复制当前index的位置
                CTRunGetPositions(run, thisGlyphRange, &position)
                // 根据当前字形创建路径
                let path = CTFontCreatePathForGlyph(runFont, glyph, nil)
                // 创建转换动画
                var transform = CGAffineTransformMakeTranslation(position.x, position.y)
                // 将当前字的路径走势添加到可变路径里
                CGPathAddPath(letters, &transform, path)
            }
         
            // 创建文字的路径
            let path = UIBezierPath()
            path.moveToPoint(CGPointZero)
            path.appendPath(UIBezierPath(CGPath: letters))
            
            pathLayer.frame = animationLayer.bounds
            pathLayer.bounds = CGPathGetBoundingBox(path.CGPath)
            pathLayer.geometryFlipped = true
            pathLayer.path = path.CGPath
            pathLayer.strokeColor = UIColor.blackColor().CGColor
            pathLayer.fillColor = textFillColor
            pathLayer.lineWidth = 1.0
            pathLayer.lineJoin = kCALineJoinBevel
            
            self.animationLayer.addSublayer(pathLayer)
        }
    }
    
    
    public func startAnimation() {
        let duration = 4.0
        pathLayer.removeAllAnimations()
        setupPathLayerWithText(textToAnimate, fontName: fontName, fontSize: fontSize)
        
        let pathAnimation       = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration  = duration
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue   = 1.0
        pathAnimation.delegate  = self
        pathLayer.addAnimation(pathAnimation, forKey: "strokeEnd")
        
        let coloringDuration    = 2.0
        let colorAnimation      = CAKeyframeAnimation(keyPath: "fillColor")
        colorAnimation.duration = duration + coloringDuration
        colorAnimation.values   = [UIColor.clearColor().CGColor, UIColor.clearColor().CGColor, textFillColor]
        colorAnimation.keyTimes = [0, (duration / (duration + coloringDuration)), 1]
        pathLayer.addAnimation(colorAnimation, forKey: "fillColor")
    }
    
    public func stopAnimation() {
        pathLayer.removeAllAnimations()
    }
    
    
    // MARK: - For Slider to drag to update
    public func prepareForAnimation() {
        pathLayer.removeAllAnimations()
        setupPathLayerWithText(textToAnimate, fontName: fontName, fontSize: fontSize)
        
        let pathAnimation       = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration  = 1.0
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue   = 1.0
        pathAnimation.delegate  = self
        pathLayer.addAnimation(pathAnimation, forKey: "strokeEnd")
        
        pathLayer.speed        = 0
    }
    
    public func updatePathStrokeWithValue(value: Float) {
        pathLayer.timeOffset = CFTimeInterval(value)
    }

    
    // MARK: - Animation Delegate
    public override func animationDidStart(anim: CAAnimation) {
        self.delegate?.textAnimationDidStart!()
    }
    
    public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.delegate?.textAnimationDidStop!()
    }
}
