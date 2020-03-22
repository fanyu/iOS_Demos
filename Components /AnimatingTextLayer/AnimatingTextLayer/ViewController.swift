//
//  ViewController.swift
//  AnimatingTextLayer
//
//  Created by FanYu on 6/22/16.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textAnimator: FYTextAnimator!
    var aView: UIView!
    
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.11, green:0.67, blue:0.92, alpha:1.00)
        
        aView = UIView(frame: CGRect(x: 50, y: 50, width: 300, height: 200))
        aView.center.x = view.center.x  
        aView.backgroundColor = UIColor.whiteColor()
        view.addSubview(aView)
        
        
        textAnimator = FYTextAnimator(referenceView: aView)
        
        slider.value = 0
        slider.enabled = false
        switcher.on = false
        
        // get all installed font
        let allFont = UIFont.familyNames()
        print(allFont)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func switchButtonTapped(sender: UISwitch) {
        if sender.on {
            slider.enabled = true 
            slider.value = 0
            textAnimator.prepareForAnimation()
        } else {
            slider.value = 0
            slider.enabled = false
            textAnimator = FYTextAnimator(referenceView: aView)
        }
    }
    
    @IBAction func startAnimation(sender: UIButton) {
        textAnimator.startAnimation()
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        textAnimator.updatePathStrokeWithValue(sender.value)
    }

}

