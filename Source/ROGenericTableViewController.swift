//
//  ROTableViewControllerGeneric.swift
//  ROTableViewController
//
//  Created by Robin Oster on 27/03/15.
//  Copyright (c) 2015 Rascor International AG. All rights reserved.
//

import UIKit

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

/**
Generic TableViewController

Inspired by the article of objc.io by Chris Eidhof
*/
public class ROGenericTableViewController : UITableViewController {
    
    private var items:[Any] = []
    private var cellForRow: (UITableView, Any) -> UITableViewCell? = { _ in return nil }
    private var didSelect:(Any) -> () = { _ in }
    
    public var swipeActions:[UITableViewRowAction] = Array<UITableViewRowAction>()
    
    override public func viewDidLoad() {
        // Custom initialization
    }
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = cellForRow(self.tableView, items[indexPath.row]) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: "CustomCell")
        }
    }
    
    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelect(items[indexPath.row])
    }
    
    override public func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        return self.swipeActions
    }
    
    override public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Otherwise the table view actions are not working
    }
}

public func createViewControllerGeneric<A>(items: [A], cellForRow: (UITableView, A) -> UITableViewCell?, select:(A) -> (), storyboardName:String? = nil, tableViewControllerIdentifier:String? = nil) -> UITableViewController {
    
    if (storyboardName != nil && tableViewControllerIdentifier != nil) {
        // Load the Custom table view cell from a storyboard
        var storyboard = UIStoryboard(name: storyboardName!, bundle: nil)
        var vc:ROGenericTableViewController = storyboard.instantiateViewControllerWithIdentifier(tableViewControllerIdentifier!) as! ROGenericTableViewController
        
        return unbox(vc, items, cellForRow, select)
    } else {
        // There was no storyboard or tableviewcontroller identifier given so create the ROTableViewControllerGeneric
        var vc:ROGenericTableViewController = ROGenericTableViewController(style: UITableViewStyle.Plain)
        
        return unbox(vc, items, cellForRow, select)
    }
}

func unbox<A>(vc:ROGenericTableViewController, items:[A], cellForRow: (UITableView, A) -> UITableViewCell?, didSelect:(A) -> ()) -> ROGenericTableViewController {
    vc.items = items.map { Box($0) }
    vc.cellForRow = {tableView, obj in
        if let value = obj as? Box<A> {
            return cellForRow(tableView, value.unbox)
        }
        
        return nil
    }
    
    vc.didSelect = { obj in
        if let value = obj as? Box<A> {
            didSelect(value.unbox)
        }
    }
    
    return vc
}

public func updateItems<A>(vc:ROGenericTableViewController, items:[A]) {
    vc.items = items.map({ Box($0)})
}


