//
//  ViewController.swift
//  UIStackViewDemo
//
//  Created by FanYu on 25/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    @IBAction func addStarTapped(sender: UIButton) {
        let starImageView = UIImageView(image: UIImage(named: "star"))
        starImageView.contentMode = .ScaleAspectFit
        
        self.horizontalStackView.addArrangedSubview(starImageView)
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.horizontalStackView.layoutIfNeeded()
        }
    }
    
    @IBAction func removeStarTapped(sender: UIButton) {
        if let star: UIView? = self.horizontalStackView.arrangedSubviews.last {
            // tell stck view that no longer needs to manage the subview's constrains
            self.horizontalStackView.removeArrangedSubview(star!)
            // remvoe the subview from the view hierarchy
            star?.removeFromSuperview()
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.horizontalStackView.layoutIfNeeded()
            })
        }
        
    }
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBAction func hideTapped(sender: UIButton) {
        if helloLabel.hidden == false {
            UIView.animateWithDuration(0.25) { () -> Void in
                self.helloLabel.hidden = true
                self.verticalStackView.layoutIfNeeded()
            }
        } else {
            UIView.animateWithDuration(0.25) { () -> Void in
                self.helloLabel.hidden = false

                self.verticalStackView.layoutIfNeeded()
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

