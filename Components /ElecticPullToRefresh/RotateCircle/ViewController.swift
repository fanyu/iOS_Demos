//
//  ViewController.swift
//  RotateCircle
//
//  Created by FanYu on 16/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//  Turitoal: http://iostuts.io/2015/10/17/elastic-bounce-using-uibezierpath-and-pan-gesture/


import UIKit

extension UIView {
    
    // 获取实时的位置 不能直接用 layer.position 这个返回的是最终点状态，而不是实时的
    func getRealTimePosition(usePresentationLayerIfPossible: Bool) -> CGPoint {
        if usePresentationLayerIfPossible, let presentationLayer = layer.presentationLayer() as? CALayer {
            return presentationLayer.position
        }
        return center
    }
}

class ViewController: UIViewController {
    
    let circleView = CircleView()
    
    // 顶部最小高度 和 波峰最大的高度
    private let minimalHeight: CGFloat = 50
    private let maxWaveHeight: CGFloat = 100
    
    private let shaperLayer = CAShapeLayer()
    private var displayLink: CADisplayLink!
    
    // 控制 DisplayLink 的开停
    private var animating = false {
        didSet {
            view.userInteractionEnabled = !animating
            displayLink.paused = !animating
        }
    }
    
    // 用 7个view 来当作控制点，也可以用CGPoint来当控制点
    private let l3ControlPointView = UIView()
    private let l2ControlPointView = UIView()
    private let l1ControlPointView = UIView()
    private let cControlPointView = UIView()
    private let r1ControlPointView = UIView()
    private let r2ControlPointView = UIView()
    private let r3ControlPointView = UIView()
    
    
    override func loadView() {
        super.loadView()
        
        // shape layer
        shaperLayer.frame     = CGRect(x: 0, y: 0, width: view.bounds.width, height: minimalHeight)
        // 用fillColor填充色彩
        shaperLayer.fillColor = UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0).CGColor
        // 取消隐式动画  减去突变效果
        shaperLayer.actions   = ["position" : NSNull(), "bounds" : NSNull(), "path" : NSNull()]
        view.layer.addSublayer(shaperLayer)
        
        // gesture
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePan:"))
        
        // subview
        view.addSubview(l3ControlPointView)
        view.addSubview(l2ControlPointView)
        view.addSubview(l1ControlPointView)
        view.addSubview(cControlPointView)
        view.addSubview(r1ControlPointView)
        view.addSubview(r2ControlPointView)
        view.addSubview(r3ControlPointView)
        
        // init
        layoutControlPoint(minimalHeight, waveHeight: 0, locationX: view.bounds.width / 2)
        updateShapeLayer()
        
        // display link
        displayLink = CADisplayLink(target: self, selector: "updateShapeLayer")
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        displayLink.paused = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        circleView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        circleView.center = self.view.center
//        self.view.addSubview(circleView)
//        
//        circleView.startRotating()
        //circleView.layer.speed = 0
        //circleView.manualRotate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController {
    
    // pan 
    func handlePan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .Ended || gesture.state == .Failed || gesture.state == .Cancelled {
            let centerY = minimalHeight
            
            animating = true
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.57, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                self.l3ControlPointView.center.y = centerY
                self.l2ControlPointView.center.y = centerY
                self.l1ControlPointView.center.y = centerY
                self.cControlPointView.center.y = centerY
                self.r1ControlPointView.center.y = centerY
                self.r2ControlPointView.center.y = centerY
                self.r3ControlPointView.center.y = centerY

                }, completion: { (Bool) -> Void in
                    self.animating = false
            })
        } else {
            let additionalHeight = max(gesture.translationInView(view).y, 0)
            
            let waveHeight = min(additionalHeight * 0.6, maxWaveHeight)
            let baseHeight = minimalHeight + additionalHeight - waveHeight
            let locationX = gesture.locationInView(view).x
            
            layoutControlPoint(baseHeight, waveHeight: waveHeight, locationX: locationX)
            updateShapeLayer()
        }
    }
    
    // control point
    func layoutControlPoint(baseHeight: CGFloat, waveHeight: CGFloat, locationX: CGFloat) {
        let width = view.bounds.width
        
        // 最左边的点 和 最右边的点 的 X 位置
        let minLeftX = min((locationX - width / 2.0) * 0.28, 0.0)
        let maxRightX = max(width + (locationX - width / 2.0) * 0.28, width)
        
        // 最左边 最右边 与 触摸点间的位置
        let leftPartWidth = locationX - minLeftX
        let rightPartWidth = maxRightX - locationX

        l3ControlPointView.center = CGPoint(x: minLeftX,                            y: baseHeight)
        l2ControlPointView.center = CGPoint(x: minLeftX + leftPartWidth * 0.44,     y: baseHeight)
        l1ControlPointView.center = CGPoint(x: minLeftX + leftPartWidth * 0.71,     y: baseHeight + waveHeight * 0.64)
        cControlPointView.center  = CGPoint(x: locationX ,                          y: baseHeight + waveHeight * 1.36)
        r1ControlPointView.center = CGPoint(x: maxRightX - rightPartWidth * 0.71,   y: baseHeight + waveHeight * 0.64)
        r2ControlPointView.center = CGPoint(x: maxRightX - (rightPartWidth * 0.44), y: baseHeight)
        r3ControlPointView.center = CGPoint(x: maxRightX,                           y: baseHeight)
    }
    
    // update bezier path
    func updateShapeLayer() {
        let width = view.bounds.width
        
        let bezierPath = UIBezierPath()
        // start point
        bezierPath.moveToPoint(CGPoint(x: 0.0, y: 0.0))
        
        // left line   0  - L3
        bezierPath.addLineToPoint(CGPoint(x: 0.0, y: l3ControlPointView.getRealTimePosition(animating).y))
        
        // curve line  L3 - L1      C1:l3 C2:l2
        bezierPath.addCurveToPoint(l1ControlPointView.getRealTimePosition(animating),
                    controlPoint1: l3ControlPointView.getRealTimePosition(animating),
                    controlPoint2: l2ControlPointView.getRealTimePosition(animating))
        
        // curve line  L1 - R1      C1:c  C2:r1
        bezierPath.addCurveToPoint(r1ControlPointView.getRealTimePosition(animating),
                    controlPoint1: cControlPointView.getRealTimePosition(animating),
                    controlPoint2: r1ControlPointView.getRealTimePosition(animating))
        
        // curve line  R1 - R3      C1:r1 C2:r2
        bezierPath.addCurveToPoint(r3ControlPointView.getRealTimePosition(animating),
                    controlPoint1: r1ControlPointView.getRealTimePosition(animating),
                    controlPoint2: r2ControlPointView.getRealTimePosition(animating))
        
        // right line  R3 - End
        bezierPath.addLineToPoint(CGPoint(x: width, y: 0.0))
        
        bezierPath.closePath()
        
        shaperLayer.path = bezierPath.CGPath
    }
    
    func startAnimation() {
        self.displayLink.paused = false
    }
    
    func stopAnimation() {
        self.displayLink.paused = true
        self.displayLink.invalidate()
        self.displayLink = nil
    }
}
