//
//  ViewController.swift
//  PiecesFallAnimationDemo
//
//  Created by FanYu on 7/26/16.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var imageView = UIImageView()
    
    private let squareSize = 20
    
    var animator: UIDynamicAnimator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        explosion()
    }
}



// MARK: - Init
//
extension ViewController {
    private func setup() {
        imageView.frame = view.frame
        imageView.contentMode = .ScaleAspectFill
        imageView.image = UIImage(named: "cat")
        view.addSubview(imageView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tapped(_:))))
    }
}


// MARK: - Actions
//
extension ViewController {
    @objc private func tapped(gesture: UITapGestureRecognizer) {
        explosion()
        //maskAnimation()
    }
}


// MARK: - Explosion Animation
// 
extension ViewController {
    
    private func explosion() {
        // 获取截图
        let snapShots = imageView.snapshotViewAfterScreenUpdates(false)

        // 创建一个放碎片的View
        let contentView = UIView(frame: view.frame)
        view.addSubview(contentView)
        
        // 存储所有的碎片
        var squares: [UIView] = []
        
        // 实例化animator
        animator = UIDynamicAnimator(referenceView: view)
        animator.delegate = self 
        
        // 进行裁剪 获取碎片
        for x in 0 ... Int(view.frame.width) / squareSize {
            for y in 0 ... Int(view.frame.height) / squareSize {
                
                // 获取每个小碎片的frame
                let squareRegion = CGRect(x: x * squareSize, y: y * squareSize, width: squareSize, height: squareSize)
                
                // 通过frame获取碎片的view 并添加到content view
                let squareShots = snapShots.resizableSnapshotViewFromRect(squareRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
                squareShots.frame.origin = squareRegion.origin
                contentView.addSubview(squareShots)
                
                // 给每个碎片添加 一个向上的推力 方向左右随机
                let push = UIPushBehavior(items: [squareShots], mode: .Instantaneous)
                push.pushDirection = CGVector(dx: randomFloatBetween(-0.15 , and: 0.15), dy: randomFloatBetween(-0.15 , and: 0))
                push.active = true
                animator.addBehavior(push)
                
                squares.append(squareShots)
            }
        }
        
        // 把所有的碎片添加重力动画
        let gravity = UIGravityBehavior(items: squares)
        //gravity.gravityDirection = CGVector(dx: 0, dy: 0.8)
        animator.addBehavior(gravity)
    }
    
    // -1 ~ 1 之间一个数
    func randomFloatBetween(smallNumber: CGFloat, and bigNumber: CGFloat) -> CGFloat {
        let diff = bigNumber - smallNumber
        return CGFloat(arc4random()) / 100.0 % diff + smallNumber
    }
}

// MARK: - Animation Delegate 
//
extension ViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
    }
    
    func dynamicAnimatorWillResume(animator: UIDynamicAnimator) {
    }
}




// MARK: - Mask Animation 
// 
extension ViewController {
    private func maskAnimation() {
        let startPath = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 50, height: 50))
        let endPath = UIBezierPath(ovalInRect: view.bounds)

        let maskLayer = CAShapeLayer()
        maskLayer.path = startPath.CGPath
        
        imageView.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath
        animation.toValue = endPath
        animation.duration = 3.0
    
        maskLayer.addAnimation(animation, forKey: "Path")
    }
}





