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
open class ROGenericTableViewController : UITableViewController {
    
    fileprivate var items:[Any] = []
    fileprivate var cellForRow: (UITableView, Any) -> UITableViewCell? = { _ in return nil }
    fileprivate var didSelect:(Any) -> () = { _ in }
    
    open var swipeActions:[UITableViewRowAction] = Array<UITableViewRowAction>()
    
    override open func viewDidLoad() {
        // Custom initialization
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = cellForRow(self.tableView, items[(indexPath as NSIndexPath).row]) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: "CustomCell")
        }
    }
    
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(items[(indexPath as NSIndexPath).row])
    }
    
    override open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return self.swipeActions
    }
    
    override open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Otherwise the table view actions are not working
    }
}

public func createViewControllerGeneric<A>(_ items: [A], cellForRow: @escaping (UITableView, A) -> UITableViewCell?, select:@escaping (A) -> (), storyboardName:String, tableViewControllerIdentifier:String) -> UITableViewController {
    
    // Load the Custom table view cell from a storyboard
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    let vc:ROGenericTableViewController = storyboard.instantiateViewController(withIdentifier: tableViewControllerIdentifier) as! ROGenericTableViewController
    
    return unbox(vc, items: items, cellForRow: cellForRow, didSelect: select)
}

public func createViewControllerGeneric<A>(_ items: [A], cellForRow: @escaping (UITableView, A) -> UITableViewCell?, select:@escaping (A) -> ()) -> UITableViewController {
    // There was no storyboard or tableviewcontroller identifier given so create the ROTableViewControllerGeneric
    let vc:ROGenericTableViewController = ROGenericTableViewController(style: UITableViewStyle.plain)
    
    return unbox(vc, items: items, cellForRow: cellForRow, didSelect: select)
}

func unbox<A>(_ vc:ROGenericTableViewController, items:[A], cellForRow: @escaping (UITableView, A) -> UITableViewCell?, didSelect:@escaping (A) -> ()) -> ROGenericTableViewController {
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

public func updateItems<A>(_ vc:ROGenericTableViewController, items:[A]) {
    vc.items = items.map({ Box($0)})
}


