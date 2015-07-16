//
//  NavigationViewController.swift
//  ROTableViewController
//
//  Created by Robin Oster on 27/03/15.
//  Copyright (c) 2015 Rascor International AG. All rights reserved.
//

import UIKit


class User {
    var firstname:String = ""
    var lastname:String = ""
    
    init(_ firstname:String, _ lastname:String) {
        self.firstname = firstname
        self.lastname = lastname
    }
}

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var user1 = User("Hugo", "Walker")
        var user2 = User("Texas", "Ranger")
        
        var cellForRow = ({ (tableView:UITableView, user:User) -> UITableViewCell in
            // CellForRowAtIndexPath
            var customCell:CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomTableViewCell?
            
            if customCell == nil {
                customCell = CustomTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CustomCell") as CustomTableViewCell
            }
            
            customCell!.setUser(user)
            
            return customCell!
        })
        
        var didCellSelect = ({(user:User) -> () in
            let detailViewController = self.storyboardLoad("DetailViewControllerScene") as DetailViewController
            self.pushViewController(detailViewController, animated: true)
        })

        // Generic CustomTableViewCell solution
        var tableViewController = createViewControllerGeneric([user1, user2], cellForRow, didCellSelect, "Main", "TableViewControllerScene") as! ROGenericTableViewController
    
        // If you need swipe actions just set the swipe actions variable
        tableViewController.swipeActions = createSwipeActions()
    
        // Update later on the data (need to use the generic outside method)
        updateItems(tableViewController, [user1, user2, user1, user2])
        tableViewController.tableView.reloadData()
        
        self.viewControllers = [tableViewController]
    }
    
    func createSwipeActions() -> [UITableViewRowAction] {
        var favAction = UITableViewRowAction(style: .Normal, title: "Swipe 1") { (action, indexPath) -> Void in
            println("Swipe 1")
        }
        
        favAction.backgroundColor = UIColor.brownColor()
        
        return [favAction]
    }
    
    func storyboardLoad<T>(sceneName:String) -> T {
        return self.storyboard?.instantiateViewControllerWithIdentifier(sceneName) as! T
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
