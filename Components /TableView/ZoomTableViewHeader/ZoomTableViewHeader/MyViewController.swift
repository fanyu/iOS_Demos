//
//  MyViewController.swift
//  
//
//  Created by FanYu on 9/14/15.
//
//

import UIKit


class MyViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TopHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var segmentControlView: UISegmentedControl!
    @IBOutlet weak var portraitImage: UIImageView!
    
    @IBAction func segmentTapped(sender: UISegmentedControl) {
        tableView.reloadData()
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    var panGesture: UIPanGestureRecognizer?
    var swipeRightGesture: UISwipeGestureRecognizer?
    var swipeLeftGesture: UISwipeGestureRecognizer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //tableView.backgroundColor = UIColor.blackColor()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.scrollsToTop = true
        
        
        topView.backgroundColor = UIColor.yellowColor()
        
        //segmentControlView.backgroundColor = UIColor.greenColor()
        
        portraitImageInit()
        
        //panGesture = UIPanGestureRecognizer(target: self, action: "panGestureHandler:")
        //tableView.addGestureRecognizer(panGesture!)
        
//        swipeRightGesture = UISwipeGestureRecognizer(target: self, action: "swipeGestureHandler:")
//        swipeRightGesture?.direction = UISwipeGestureRecognizerDirection.Right
//        
//        swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "swipeGestureHandler:")
//        swipeLeftGesture?.direction = UISwipeGestureRecognizerDirection.Left
//        
//        tableView.addGestureRecognizer(swipeRightGesture!)
//        tableView.addGestureRecognizer(swipeLeftGesture!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func portraitImageInit() {
        portraitImage.clipsToBounds = true
        portraitImage.layer.cornerRadius = 50
        //portraitImage.layer.borderWidth = 2
        //portraitImage.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func panGestureHandler(gesture: UIPanGestureRecognizer) {
        var currentX = gesture.translationInView(tableView).y
        let segIndex = segmentControlView.selectedSegmentIndex
        print("\(currentX)")
        
        if gesture.state == UIGestureRecognizerState.Began {
            print("Begin")
        } else if gesture.state == UIGestureRecognizerState.Cancelled {
            if currentX < 0 { // left
        
                self.segmentControlView.selectedSegmentIndex = min(2, segIndex + 1)
                self.tableView.reloadData()
            } else {    //right
                self.segmentControlView.selectedSegmentIndex = min(2, segIndex + 1)
                self.tableView.reloadData()
            }
        } else if gesture.state == .Ended {
            currentX = 0
        }
    }
    
//    func swipeGestureHandler(gesture: UISwipeGestureRecognizer) {
//        let segIndex = segmentControlView.selectedSegmentIndex
//        
//        if gesture.direction == UISwipeGestureRecognizerDirection.Left {
//            //UIView.animateWithDuration(0.8, animations: { () -> Void in
//                self.segmentControlView.selectedSegmentIndex = min(2, segIndex + 1)
//                self.tableView.reloadData()
//            //})
//            println("swipt Left")
//
//        } else {
//            //UIView.animateWithDuration(0.8, animations: { () -> Void in
//                self.segmentControlView.selectedSegmentIndex = max(0, segIndex - 1)
//                self.tableView.reloadData()
//            //})
//            
//            println("swipt Right")
//        }
//    }
}



// MARK: - Table View DataSource
extension MyViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        if segmentControlView.selectedSegmentIndex == 0 {
            cell!.textLabel?.text = "First \(indexPath.item)"
        } else if segmentControlView.selectedSegmentIndex == 1 {
            cell!.textLabel?.text = "Second \(indexPath.item)"
        } else {
            cell!.textLabel?.text = "Third \(indexPath.item)"
        }
        
        
        return cell!
    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let back = UIView(frame: CGRect(x: 0, y: 200, width: tableView.frame.width, height: 50))
//        back.backgroundColor = UIColor.redColor()
//        //tableView.tableHeaderView?.backgroundColor = UIColor.redColor()
//        
//        return back
//    }
}


// MARK: - Scroll View
extension MyViewController {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset
        let percentage = CGRectGetMaxY(topView.frame) / CGFloat(200)
        let scale = min(1, max(0.3, percentage))
        
        
        // up
        if offset.y > 0 {
            print("Up offset \(offset.y) \t tableViewY \(tableView.frame.origin.y) \t \(percentage)")
            topView.frame.size.height = max(50, topView.frame.size.height - offset.y - 10)
            TopHeightConstraint.constant = max(50, topView.frame.size.height)
            self.view.layoutIfNeeded()
            
            
            if offset.y > 2 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.topView.frame.size.height = 50
                    self.TopHeightConstraint.constant = self.topView.frame.size.height
                    self.portraitImage.transform = CGAffineTransformMakeScale(scale, scale)
                    self.view.layoutIfNeeded()
                })
            }
        } else { // down
            
            print("Down \(CGRectGetMaxY(topView.frame)) \t offset \(offset.y) \t \(percentage)")
            
            topView.frame.size.height = min(topView.frame.size.height - offset.y, 200)
            TopHeightConstraint.constant = min(topView.frame.size.height,200)
            //self.view.layoutIfNeeded()
            
            if CGRectGetMaxY(topView.frame) > 60 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.topView.frame.size.height = 200
                    self.TopHeightConstraint.constant = 200
                    self.portraitImage.transform = CGAffineTransformMakeScale(scale, scale)
                    self.view.layoutIfNeeded() // Lays out the subviews immediately. more fluency
                })
            }
        
            if topView.frame.size.height >= 200 {
                tableView.setContentOffset(CGPointZero, animated: false)
            }
        }
    }
    
    
}




    