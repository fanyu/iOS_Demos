//
//  ViewController.swift
//  3DTouch
//
//  Created by FanYu on 8/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class ForceViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var fromText: String!
    
    @IBOutlet weak var upLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = fromText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func previewActionItems() -> [UIPreviewActionItem] {
        let helloAction = UIPreviewAction(title: "Hello", style: UIPreviewActionStyle.Default) { (UIPreviewAction, UIViewController) -> Void in
    
        }
        
        let deleteAction = UIPreviewAction(title: "Delete", style: UIPreviewActionStyle.Destructive) { (UIPreviewAction, UIViewController) -> Void in
            
        }
        
        let otherAction = UIPreviewActionGroup(title: "Other", style: UIPreviewActionStyle.Default, actions: [helloAction, deleteAction])
        
        return [helloAction, deleteAction, otherAction]
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touche = touches.first where traitCollection.forceTouchCapability == .Available {
            self.label.text = "\(touche.force)"
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
