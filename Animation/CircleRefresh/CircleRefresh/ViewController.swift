//
//  ViewController.swift
//  CircleRefresh
//
//  Created by FanYu on 5/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let bothEndMove = EDCCircleRealTimeDraw()

    @IBAction func buttonTapped(sender: UIButton) {
        
        let animation = CABasicAnimation(keyPath: "progress")
        animation.duration = 3
        animation.fromValue = 0
        animation.toValue = 1
        animation.delegate = self
        animation.setValue("Progress", forKey: "Animation")
        bothEndMove.addAnimation(animation, forKey: "ddd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        oralLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func circleShape() {
        let circleShape = EDCCircleShapeLayer()
        circleShape.contentsScale = UIScreen.mainScreen().scale
        circleShape.frame = CGRectMake(100, 100, 100, 100)
        self.view.layer.addSublayer(circleShape)
    }
    
    private func circleDraw() {
        // 防止失真
        bothEndMove.contentsScale = UIScreen.mainScreen().scale
        bothEndMove.bounds = CGRectMake(0, 0, 200, 200)
        bothEndMove.position = self.view.center
        bothEndMove.progress = 1
        self.view.layer.addSublayer(bothEndMove)
    }
    
    private func lineLayer() {
        // line
        let line = EDCSegmentMove()
        line.frame = CGRectMake(0, 20, 200, 10)
        line.position = CGPointMake(200, 10)
        self.view.layer.addSublayer(line)
    }
    
    private func rightMark() {
        let rightMark = EDCRightMarkLayer()
        rightMark.bounds = CGRectMake(0, 0, 200, 200)
        rightMark.position = self.view.center
        self.view.layer.addSublayer(rightMark)
    }
    
    private func oralLayer() {
        let oral = EDCRealTimeOralLayer()
        oral.bounds = CGRectMake(0, 0, 200, 200)
        oral.position = CGPointMake(100, 100)
        self.view.layer.addSublayer(oral)
        
        // animation 
        let animation = CABasicAnimation(keyPath: "progress")
        animation.duration = 3
        animation.fromValue = 0
        animation.toValue = 1
        animation.delegate = self
        animation.setValue("Progress", forKey: "Animation")
        oral.addAnimation(animation, forKey: "ddd")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("heelo")
        
        if ((anim.valueForKey("Animation")?.isEqualToString("Progress")) != nil) {
            print("Yep")
            // right mark layer
            rightMark()
        }
    }
}

