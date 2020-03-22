//
//  ExtensionForTableView.swift
//  ChatDemo
//
//  Created by FanYu on 7/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import Foundation
import UIKit


// MARK: - TableView DataSource and Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // datasource
    // 111 : execute sequence
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(111)
        return chatText.count
    }
    
    // 222
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //print(222)
        return 65
    }
    
    // 333
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ChatTableViewCell
        
        cell.textView.text = ""
        
        self.handleCell(cell, indexPath: indexPath.row)
        self.cell = cell
        
        //print(333)
        return cell
    }
    
    // 444
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cannot call tableView.cellForRowAtIndexPath(indexPath: NSIndexPath) in this func
        //print(444)
        return cell.height
    }
    
    // selected color 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.yellow
    }
}


// MARK: - Scroll


// MARK: - Helper
extension ViewController {
    
    func handleCell(_ cell: ChatTableViewCell, indexPath: Int) {
        let cell = cell
        let top = (cell.defaultTextViewHeight - (cell.textView.font?.lineHeight)!) / 2
        
        //print(indexPath)
        // right
        if indexPath % 2 == 0 {
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            
            cell.textView.backgroundColor = UIColor(red:0.02, green:0.6, blue:0.99, alpha:1)
            // 必须先给内容，然后左右对齐，否则拍版会出错误
            cell.textView.text = "\(chatText[indexPath])"
            if numberOfLines(cell) == 1 {
                cell.textView.textAlignment = .right
                // make it vertical center
                cell.textView.textContainerInset = UIEdgeInsets(top: top, left: 1, bottom: 0, right: 1)
            } else {
                cell.textView.textAlignment = .left
            }
            // change the position
            //cell.textView.sizeToFit()
            //cell.textView.frame.origin.x = width - cell.horiSpace - cell.textView.frame.size.width
        }
        // left
        else {
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            
            cell.textView.backgroundColor = UIColor(red:0.65, green:0.93, blue:0.36, alpha:1)
            cell.textView.text = "\(chatText[indexPath])"
            cell.textView.textAlignment = .left
            if numberOfLines(cell) == 1 {
                // make text vertical center
                cell.textView.textContainerInset = UIEdgeInsets(top: top, left: 1, bottom: 0, right: 1)
            }
            //cell.textView.sizeToFit()
        }
        
        // cell height
        cell.height = hightForContent(cell) + cell.vertSpace * 2
        
        // text view frame
        cell.textView.frame.size.height = hightForContent(cell)
    }
    
    
    func hightForContent(_ cell: ChatTableViewCell) ->CGFloat {
        let numberOfLines = floor(cell.textView.contentSize.height / (cell.textView.font?.lineHeight)!)
        
        var height = 30 - (cell.textView.font?.lineHeight)!
        height += CGFloat(numberOfLines) * (cell.textView.font?.lineHeight)!
        
        if height <= cell.defaultTextViewHeight {
            // 这个数 不能与 estimateHeight 返回的数一样大小，否则cell显示的高度有问题
            return cell.defaultTextViewHeight
        }
        
        return height
    }
    
    func numberOfLines(_ cell: ChatTableViewCell) ->Int {
        let numberOfLines = cell.textView.contentSize.height / (cell.textView.font?.lineHeight)!
        
        if numberOfLines < 1 {
            return 1
        }
        
        return Int(numberOfLines)
    }
}
