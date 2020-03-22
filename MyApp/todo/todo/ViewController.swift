//
//  ViewController.swift
//  todo
//
//  Created by FanYu on 2/17/15.
//  Copyright (c) 2015 FanYu. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []

//convert string to date 
func dateFromString(dateStr: String) ->NSDate?
{
    let dateFormater = NSDateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd"
    let date = dateFormater.dateFromString(dateStr)
    return date
    
    //let df = NSDateFormatter.dateFormat("yyyy-MM-dd")
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate
{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todos =
            [
                TodoModel(id: "1", image: "child-selected", title: "Go to gym", date: dateFromString("2015-02-17")!),
                TodoModel(id: "2", image: "phone-selected", title: "call me", date: dateFromString("2015-02-17")!),
                TodoModel(id: "3", image: "shopping-cart-selected", title: "big meal", date: dateFromString("2015-02-17")!),
                TodoModel(id: "4", image: "travel-selected", title: "to usa", date: dateFromString("2015-02-17")!)
            ]
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        var contentOffset = tableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as! UITableViewCell
        
        var todo = todos[indexPath.row] as TodoModel
        
        var image = cell.viewWithTag(101) as! UIImageView
        var title = cell.viewWithTag(103) as! UILabel
        var date = cell.viewWithTag(102) as! UILabel
        
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
        var local = NSLocale.currentLocale()
        var Formater = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: local)
        
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = Formater
        date.text = dateFormat.stringFromDate(todo.date)
        
        //var text = dateFormat.stringFromDate(todo.date)
        
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            todos.removeAtIndex(indexPath.row)
            //self.tableView.reloadData()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 80
    }
    
    //Editing Mode
    override func setEditing(editing: Bool, animated: Bool)
    {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    //return segue
    @IBAction func close(segue: UIStoryboardSegue)
    {
        println("closed")
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "EditTodo"
        {
            var vc = segue.destinationViewController as! DetailViewController
            var indexPath = tableView.indexPathForSelectedRow()
            if let index = indexPath
            {
                vc.todo = todos[index.row]
            }
        }
    }
}

