//
//  ViewController.swift
//  CoreAnimation
//
//  Created by FanYu on 9/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let iamge = UIImage(named: "rainbow")
    var label = UILabel()
    let backView = UIView()
    let reflectionView = ReflectionView()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet var colorViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.view.layer.contents = iamge?.CGImage
        //view.contentMode = .ScaleAspectFit
        //view.layer.contentsGravity = kCAGravityResizeAspect
        view.backgroundColor = UIColor.lightGrayColor()
        
        backView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        backView.backgroundColor = UIColor.whiteColor()
        backView.addSubview(label)
        backView.center = view.center
        //view.addSubview(backView)
        
        label.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        label.text = "Hello"
        label.backgroundColor = UIColor.whiteColor()
        label.alpha = 0.5
        
        label.layer.shouldRasterize = true
        label.layer.rasterizationScale = UIScreen.mainScreen().scale
    
        //sublayerTransform()
        //colorViewCuic()
        //textLayer()
        //repelicatorLayer()
        //reflection()
        rotateDoor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    
    func mutltiTransition() {
        UIView.animateWithDuration(3) { () -> Void in
            var transform = CGAffineTransformIdentity
            transform = CGAffineTransformScale(transform, 0.5, 0.5)
            transform = CGAffineTransformRotate(transform, 200)
            transform = CGAffineTransformTranslate(transform, 200, 0)
            self.backView.transform = transform
        }
    }

    func ThreeDTransition() {
        var transform = CATransform3DIdentity
        // apply perspective
        transform.m34 = -1.0 / 500
        // rotate by 45 degrees along the Y axis
        transform = CATransform3DRotate(transform, CGFloat(M_PI_4), 0, 1, 0)
        // apply to layer
        backView.layer.transform = transform
    }
    
    func sublayerTransform() {
        // perspective
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500
        self.containerView.layer.sublayerTransform = perspective
        
        // rotate left image by 45
        let transformLeft = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 1, 0)
        self.leftImageView.layer.transform = transformLeft
        //self.leftImageView.layer.doubleSided = false
        
        // rotate right imge by 45
        let transformRight = CATransform3DMakeRotation(CGFloat(-M_PI_4), 0, 1, 0)
        self.rightImageView.layer.transform = transformRight
    }
    
    func colorViewCuic() {
        // add Views
        for view in colorViews {
            view.frame = CGRect(x: containerView.frame.size.width / 2 - 30, y: containerView.frame.size.height / 2 - 30, width: 60, height: 60)
            containerView.addSubview(view)
        }
        
        // perspective
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500
        self.containerView.layer.sublayerTransform = perspective
        
        // cube face 1
        var transform = CATransform3DMakeTranslation(0, 0, 100)
        colorViews[0].layer.transform = transform
        
        // cube face 2
        transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 0, 1, 0)
    }
    
    func cornerRect() {
        let corner = [UIRectCorner.TopLeft, UIRectCorner.BottomLeft, UIRectCorner.BottomRight]
        //let path = UIBezierPath(roundedRect: <#T##CGRect#>, byRoundingCorners: <#T##UIRectCorner#>, cornerRadii: <#T##CGSize#>)
    }
    
    func textLayer() {
        // label view
        let labelView = UIView(frame: CGRect(x: 10, y: 20, width: 200, height: 200))
        
        // text layer
        let textLayer = CATextLayer()
        textLayer.frame = labelView.frame
        labelView.layer.addSublayer(textLayer)
        
        // attributes
        textLayer.foregroundColor = UIColor.whiteColor().CGColor
        textLayer.alignmentMode = kCAAlignmentJustified
        textLayer.wrapped = true
        textLayer.fontSize = UIFont.systemFontSize()
        textLayer.string = "What do mean? How do you like OralHub App? "
        
        // clear 
        textLayer.contentsScale = UIScreen.mainScreen().scale
        self.view.addSubview(labelView)
    }
    
    func repelicatorLayer() {
        // replicator layer and add it to container view layer
        let replicator = CAReplicatorLayer()
        replicator.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(replicator)
        
        // set replicator
        replicator.instanceCount = 10
        
        // 3D transform
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 200, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI / 5), 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -200, 0)
        replicator.instanceTransform = transform
        
        // apply a color shift for each instance 
        replicator.instanceBlueOffset = -0.1
        replicator.instanceGreenOffset = -0.1
        
        // create a sublayer which needed dulicate and place it inside the replicator
        let layer = CALayer()
        layer.frame = CGRect(x: 100, y: 10, width: 100, height: 100)
        layer.backgroundColor = UIColor.whiteColor().CGColor
        replicator.addSublayer(layer)
    }
    
    func reflection() {
        var replicator = CAReplicatorLayer()
        replicator.instanceCount = 2
        
        // transform 3D
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, self.leftImageView.frame.size.width, 0)
        transform = CATransform3DScale(transform, 1, -1, 0)
        replicator.transform = transform
        replicator.instanceAlphaOffset = -0.6
        
        let layer = CALayer()
        layer.contents = leftImageView.image
        replicator.addSublayer(leftImageView.layer)
    }
    
    func emitter() {
        // create particle emitter layer
        var emitter = CAEmitterLayer()
        emitter.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(emitter)
        
        // configure emitter
        emitter.renderMode = kCAEmitterLayerAdditive
        emitter.emitterPosition = CGPoint(x: emitter.frame.size.width / 2, y: emitter.frame.size.height / 2)
        
        // create a particle template 
        var cell = CAEmitterCell()
        //cell.contents =
    }
    
    func rotateDoor() {
        let doorLayer = CALayer()
        doorLayer.frame = CGRect(x: 100, y: 150, width: 50, height: 60)
        doorLayer.contents = UIImage(named: "rainbow")?.CGImage
        doorLayer.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.view.layer.addSublayer(doorLayer)
        
        // perspective 
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500
        self.view.layer.sublayerTransform = perspective
        
        // animation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationAnimation.toValue = -M_PI_2
        rotationAnimation.duration = 2
        rotationAnimation.autoreverses = true
        rotationAnimation.speed = 0
        rotationAnimation.repeatCount = HUGE
        doorLayer.addAnimation(rotationAnimation, forKey: "ro")
        
                
        // pan gesture 
//        let panRecognizer = UIPanGestureRecognizer(target: self, action: "pan:")
//        self.view.addGestureRecognizer(panRecognizer)
//        
//        func pan(sender: UIPanGestureRecognizer) {
//            var position = sender.translationInView(self.view).x
//            position /= 200
//            var timeOffset = doorLayer.timeOffset
//            timeOffset = min(1, max(0, timeOffset - CFTimeInterval(position)))
//            doorLayer.timeOffset = timeOffset
//            sender.setTranslation(CGPoint.zero, inView: self.view)
//        }
    }
    
    func interpolate(from: CGFloat, to: CGFloat, time: CGFloat) ->CGFloat {
        return (to - from) * time + from
    }
    
    func interpolateFromValue(fromValue: AnyObject, toValue: AnyObject, time: CGFloat) ->AnyObject {
        if fromValue.isKindOfClass(NSValue) {
            
            let from   = fromValue.CGPointValue
            let to     = fromValue.CGPointValue
            let result = CGPoint(x: interpolate(from.x, to: to.x, time: time),
                                 y: interpolate(from.y, to: to.y, time: time) )
            return NSValue(CGPoint: result)
        }
        return time < 0.5 ? fromValue : toValue
    }
    
    func generateKeyFrames(duration: CFTimeInterval, fromValue: CGFloat, toValue: CGFloat) -> [AnyObject] {
        let numFrames = duration * 60
        let frames = NSMutableArray()
        for i in 0 ... Int(numFrames) {
            let time = 1 / Int(numFrames) * i
            
            //time = bounceEaseOut(time)
            frames.addObject(interpolateFromValue(fromValue, toValue: toValue, time: CGFloat(time)))
        }
        return frames as [AnyObject]
    }
    
    func keyFrameAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 1
        animation.delegate = self
        animation.values = generateKeyFrames(1, fromValue: 1, toValue: 1)
    }
}




