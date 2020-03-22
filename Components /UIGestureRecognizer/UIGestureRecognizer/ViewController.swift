//
//  ViewController.swift
//  UIGestureRecognizer
//
//  Created by FanYu on 8/21/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var chompPlayer: AVAudioPlayer?
    
    @IBOutlet var bananaPan: UIPanGestureRecognizer!
    @IBOutlet var monkyPan: UIPanGestureRecognizer!
    
    func loadSound(filename: NSString) ->AVAudioPlayer {
        let url = NSBundle.mainBundle().URLForResource(filename as String, withExtension: "caf")
        var error: NSError?
        let player = AVAudioPlayer(contentsOfURL: url, error: &error)
        if error != nil {
            println("Eoor loading \(url): \(error?.localizedDescription)")
        } else {
            player.prepareToPlay()
        }
        return player
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //MARK: - Tap Gesture
        // filter to get imageview
        let filteredSubviews = self.view.subviews.filter( {$0.isKindOfClass(UIImageView)} )
        // create tap gesture for each image view
        for view in filteredSubviews {
            let recognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            recognizer.delegate = self
            
            // let pan gesture fail
            recognizer.requireGestureRecognizerToFail(monkyPan)
            recognizer.requireGestureRecognizerToFail(bananaPan)
            
            view.addGestureRecognizer(recognizer)
        }
        self.chompPlayer = self.loadSound("chomp")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        self.chompPlayer?.play()
    }


    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        
        // MARK: - Move
        // retrieve the amount the user has remvoed
        let translation = sender.translationInView(self.view)
        // add amount to view
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        // reset translation as zero 
        sender.setTranslation(CGPointZero, inView: self.view)

        
        // MARK: - Deceleraton
        if sender.state == UIGestureRecognizerState.Ended {
            // figure out the length of velocity vector
            let velocity = sender.velocityInView(self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            // decrease : lenght < 200     incrase : length > 200
            let slideMutiplier = magnitude / 200
            let slideFactor = 0.1 * slideMutiplier
            // calcualte final point
            var finalPoint = CGPoint(x: sender.view!.center.x + (velocity.x * slideFactor), y: sender.view!.center.y + (velocity.y * slideFactor))
            // make sure the point is within the view's bounds
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            // animate the view, usw ease out to slow down the movement over time
            UIView.animateWithDuration( Double(slideFactor * 2),
                                        delay: 0,
                                        options: UIViewAnimationOptions.CurveEaseOut,
                                        animations: { sender.view?.center = finalPoint },
                                        completion: nil
                                      )
        }
    }
    
    @IBAction func handlePinch(sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            view.transform = CGAffineTransformScale(view.transform, sender.scale, sender.scale)
            sender.scale = 1
            print("pinch")
        }
    }
    
    @IBAction func handleRotate(sender: UIRotationGestureRecognizer) {
        if let view = sender.view {
            view.transform = CGAffineTransformRotate(view.transform, sender.rotation)
            sender.rotation = 0
            println("rotate")
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
