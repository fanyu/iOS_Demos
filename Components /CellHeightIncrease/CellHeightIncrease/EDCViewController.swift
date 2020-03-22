//
//  EDCViewController.swift
//  CellHeightIncrease
//
//  Created by FanYu on 30/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

class EDCViewController: UIViewController {

    private let tableView = TableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setup() {
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // sub 
        self.view.addSubview(tableView)
        
        // constraitn 
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
}
