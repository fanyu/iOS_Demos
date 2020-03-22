//
//  ViewController.swift
//  EDCCinema
//
//  Created by FanYu on 11/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // screen proterty
    var width: CGFloat { return UIScreen.mainScreen().bounds.size.width }
    var height: CGFloat { return UIScreen.mainScreen().bounds.size.height }
    
    // color
    let blueColor = UIColor(red:0.168, green:0.574, blue:0.973, alpha:1)
    
    //
    @IBOutlet weak var cinemaView: UIView!
    @IBOutlet weak var seatView: UIView!
    let posterView = UIView()
    let posterHeaderView = UIView()
    let textView = UITextView()
    let blueButton = BlueButtonView()
    let circleButton = UIButton()
    var showingSeats: Bool = false
    var posterWidth: CGFloat = 0
    var posterHeight: CGFloat = 0
    var numSelected: Int = 0
    
    // seat button tapped
    @IBAction func seatButtonTapped(sender: UIButton) {
        if sender.backgroundColor == blueColor {
            sender.backgroundColor = UIColor.lightGrayColor()
            numSelected -= 1
        } else {
            sender.backgroundColor = blueColor
            numSelected += 1
        }
        
        self.blueButton.actionLabel.text = "Done"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - Set up views
//
extension ViewController {
    func setup() {
        
        // cinema view
        cinemaView.clipsToBounds = true
        
        // poster Header view
        posterHeaderView.frame = CGRect(x: 15, y: 40, width: (cinemaView.bounds.size.width + 56) * 0.9, height: 3)
        posterHeaderView.backgroundColor = blueColor
        posterHeaderView.alpha = 0
        self.cinemaView.addSubview(posterHeaderView)
        
        // poster view
        posterView.frame = CGRect(x: 0, y: -80, width: cinemaView.bounds.size.width + 56, height: 160)
        posterView.backgroundColor = UIColor.blackColor()
        posterView.layer.contents = UIImage(named: "transformer")?.CGImage
        posterView.layer.contentsGravity = kCAGravityResizeAspect
        posterView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.cinemaView.addSubview(posterView)
        posterWidth = cinemaView.bounds.size.width + 56
        posterHeight = 160
        
        // text view
        textView.frame = CGRect(x: 10, y: 160, width: cinemaView.bounds.size.width + 46, height: cinemaView.bounds.size.height - 100)
        textView.font = UIFont.systemFontOfSize(14)
        textView.editable = false
        textView.textColor = UIColor(red:0.74, green:0.727, blue:0.74, alpha:1)
        textView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        textView.text = "Many years ago, the planet Cybertron was consumed by a civil war by the two Transformer factions, the Autobots led by Optimus Prime, and the Decepticons led by Megatron. Optimus jettisoned the AllSpark, a mystical artefact that brings life to the planet, into space, but Megatron pursued it. Megatron crashed in the Arctic Circle and froze, discovered in 1897 by explorer Archibald Witwicky. Witwicky activated Megatron’s navigational system, which scanned the AllSpark’s coordinates into his glasses. The glasses end up in the possession of his great-great-grandson Sam Witwicky. In the present day, Sam buys his first car, a rusting Chevrolet Camaro, but discovers it has a life of its own"
        self.cinemaView.addSubview(textView)
        
        // button view
        blueButton.frame = CGRect(x: 20, y: 140, width: cinemaView.bounds.size.width + 20, height: 60)
        blueButton.actionLabel.text = "Buy"
        blueButton.priceLabel.text = "$29.9"
        self.cinemaView.addSubview(blueButton)
        let tapRecgnizer = UITapGestureRecognizer(target: self, action: "buttonTapped:")
        blueButton.addGestureRecognizer(tapRecgnizer)
        
        // circle button
        circleButton.frame = CGRect(x: 17, y: cinemaView.bounds.size.height + 26, width: 60, height: 60)
        circleButton.layer.cornerRadius = 30
        circleButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        circleButton.layer.shadowOpacity = 0.5
        circleButton.layer.shadowRadius = 10
        circleButton.layer.shadowColor = UIColor.lightGrayColor().CGColor
        circleButton.setImage(UIImage(named: "Back"), forState: .Normal)
        circleButton.alpha = 0
        circleButton.addTarget(self, action: "backTapped:", forControlEvents: .TouchUpInside)
        self.cinemaView.addSubview(circleButton)
    }
}


// MARK: - Handler
//
extension ViewController {
    
    func buttonTapped(sender: UITapGestureRecognizer) {
        if showingSeats {
            disappearAnimation()
        } else {
            appearAnimation()
        }
    }
    
    func backTapped(sender: UIButton) {
        disappearAnimation()
        
    }
}


// MARK: - Animation
//
extension ViewController {
    
    func appearAnimation() {
        
        // show flag
        showingSeats = true
        
        // button view
        var transform = CGAffineTransformIdentity
        transform = CGAffineTransformScale(transform, 0.7, 0.7)
        transform = CGAffineTransformTranslate(transform, 70, self.cinemaView.bounds.size.height - 70)
        
        // seat view 
        let seatTransform = CGAffineTransformMakeScale(1.3, 1.3)
        seatView.transform = seatTransform
        seatView.alpha = 0.4
        
        // poster view rotation
        self.posterView.layer.addAnimation(appeartRotationAnimation(), forKey: "show")
        
        // poster view frame change
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.posterView.frame = CGRect(x: 0.05 * self.posterWidth, y: 40, width: self.posterWidth * 0.9, height: 3)
            }) { (Bool) -> Void in
                self.posterView.alpha = 0
        }
        
        // show header and circle button
        UIView.animateWithDuration(0.6, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.posterHeaderView.alpha = 1
            self.circleButton.alpha = 1
            }) { (Bool) -> Void in
        }
        
        // bluebutton and textView and seat animation
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.blueButton.transform = transform
            self.textView.transform = transform
            self.textView.alpha = 0
            self.seatView.transform = CGAffineTransformMakeScale(1, 1)//CGAffineTransformIdentity
            self.seatView.alpha = 0.8
            self.blueButton.actionLabel.text = "Please select seats."
            self.blueButton.priceLabel.text = ""
            
            }) { (Bool) -> Void in
                self.posterView.frame = CGRect(x: 0, y: 30, width: self.posterWidth, height: 160)
                self.posterView.layer.removeAnimationForKey("show")
        }
    }
    
    
    func disappearAnimation() {
        // flag 
        showingSeats = false
        
        // hide circle button
        self.circleButton.alpha = 0
        
        // button View
        var buttonTransform = CGAffineTransformIdentity
        buttonTransform = CGAffineTransformScale(buttonTransform, 1, 1)
        buttonTransform = CGAffineTransformTranslate(buttonTransform, 0, 0)
        
        // seat view
        var seatTransform = CGAffineTransformMakeScale(1.3, 1.3)
        
        // prepare
        posterHeaderView.alpha = 0
        posterView.alpha = 1
        self.posterView.frame = CGRect(x: 0.05 * self.posterWidth, y: 40, width: self.posterWidth * 0.9, height: 160)
        
        // animation
        posterView.layer.addAnimation(disapperRotationAnimation(), forKey: "disapper")
        
        // frame change
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.posterView.frame = CGRect(x: 0, y: 0, width: self.posterWidth, height: 160)
            }) { (Bool) -> Void in
                self.posterView.alpha = 1
        }
        
        //
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.blueButton.transform = buttonTransform
            self.textView.transform = buttonTransform
            self.textView.alpha = 1
            self.seatView.transform = seatTransform//CGAffineTransformIdentity
            self.seatView.alpha = 0
            self.blueButton.actionLabel.text = "Buy"
            self.blueButton.priceLabel.text = "$29.9"
            self.circleButton.alpha = 0
            }) { (Bool) -> Void in
                
                seatTransform = CGAffineTransformMakeScale(1, 1)
                self.posterView.layer.removeAnimationForKey("disapper")
        }
    }
    
    func appeartRotationAnimation() ->CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: "transform")
        rotationAnimation.fromValue = NSValue(CATransform3D: rotationTransform(0, perspective: true))
        rotationAnimation.toValue = NSValue(CATransform3D: rotationTransform(89, perspective: true))
        rotationAnimation.duration = 0.4
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = 1
        rotationAnimation.removedOnCompletion = false
        rotationAnimation.autoreverses = false
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        return rotationAnimation
    }
    
    func disapperRotationAnimation() ->CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: "transform")
        rotationAnimation.fromValue = NSValue(CATransform3D: rotationTransform(90, perspective: true))
        rotationAnimation.toValue = NSValue(CATransform3D: rotationTransform(0, perspective: false))
        rotationAnimation.duration = 0.4
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = 1
        rotationAnimation.autoreverses = false
        rotationAnimation.removedOnCompletion = false
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        return rotationAnimation
    }
    
    func rotationTransform(angle: CGFloat, perspective: Bool) ->CATransform3D {
            let radius = angle * CGFloat(M_PI) / 180
        var transform = CATransform3DIdentity
        if perspective {
            transform.m34 = 4.5 / 2000
        } else {
            transform.m34 = 0
        }
        transform = CATransform3DRotate(transform, radius, 1, 0, 0)
        
        return transform
    }

}
