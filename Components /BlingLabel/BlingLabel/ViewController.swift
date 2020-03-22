//
//  ViewController.swift
//  BlingLabel
//
//  Created by FanYu on 6/21/16.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var blingBlingLabel:FYBlingBlingLabel!
    let textArray = ["轻轻的我走了，正如我轻轻的来；\n我轻轻的招手，作别西天的云彩。",
                     "Very quietly I take my leave, As quietly as I came here; \nQuietly I wave good-bye, To the rosy clouds in the western sky.",
                     "Douce et légère est ma démarche\nTout comme mon arrivée, légère\nMa main salue gentiment\nPour prendre congé des brumes de l’ouest."];
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 42/255.0, green: 49/255.0, blue: 67/255.0, alpha: 1)
        
        blingBlingLabel = FYBlingBlingLabel.init(frame: CGRectMake(0, 0, 300, 200))
        blingBlingLabel.needAnimation = true
        blingBlingLabel.center = self.view.center
        blingBlingLabel.numberOfLines = 0
        blingBlingLabel.font = UIFont.systemFontOfSize(23)
        blingBlingLabel.textColor = UIColor.whiteColor()
        blingBlingLabel.userInteractionEnabled = true
        self.view.addSubview(blingBlingLabel)
        
        blingBlingLabel.text = textArray[0 % textArray.count]
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(ViewController.changeText))
        blingBlingLabel?.addGestureRecognizer(tap)
    }
    
    func changeText() {
        i += 1
        blingBlingLabel?.text = textArray[i % textArray.count]
    }

    @IBAction func switchTapped(sender: UISwitch) {
        blingBlingLabel.needAnimation = sender.on
    }
    
    @IBAction func onlyAppearTapped(sender: UISwitch) {
    }
    
}

