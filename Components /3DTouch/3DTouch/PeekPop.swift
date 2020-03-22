//
//  PeekPop.swift
//  3DTouch
//
//  Created by FanYu on 8/11/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import Foundation
import UIKit

extension TableViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let forceVC = self.storyboard?.instantiateViewControllerWithIdentifier("PreviewController") as? ForceViewController else { return nil }
        forceVC.preferredContentSize = CGSize.zero
        
        guard let indexPath = tableView.indexPathForRowAtPoint(location),
            cell = tableView.cellForRowAtIndexPath(indexPath) as? TableViewCell else { return nil }
        
        forceVC.fromText = cell.label!.text
        
        return forceVC
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        // pop
        showViewController(viewControllerToCommit, sender: self)
    }
    
}