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
        
        let user1 = User("Hugo", "Walker")
        let user2 = User("Texas", "Ranger")
        
        let cellForRow = ({ (tableView:UITableView, user:User) -> UITableViewCell in
            // CellForRowAtIndexPath
            var customCell:CustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell?
            
            if customCell == nil {
                customCell = CustomTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CustomCell") as CustomTableViewCell
            }
            
            customCell!.setUser(user)
            
            return customCell!
        })
        
        let didCellSelect = ({(user:User) -> () in
            let detailViewController = self.storyboardLoad("DetailViewControllerScene") as DetailViewController
            self.pushViewController(detailViewController, animated: true)
        })

        // Generic CustomTableViewCell solution
        let tableViewController = createViewControllerGeneric([user1, user2], cellForRow: cellForRow, select: didCellSelect, storyboardName: "Main", tableViewControllerIdentifier: "TableViewControllerScene") as! ROGenericTableViewController
    
        // If you need swipe actions just set the swipe actions variable
        tableViewController.swipeActions = createSwipeActions()
    
        // Update later on the data (need to use the generic outside method)
        updateItems(tableViewController, items: [user1, user2, user1, user2])
        tableViewController.tableView.reloadData()
        
        self.viewControllers = [tableViewController]
    }
    
    func createSwipeActions() -> [UITableViewRowAction] {
        let favAction = UITableViewRowAction(style: .normal, title: "Swipe 1") { (action, indexPath) -> Void in
            print("Swipe 1")
        }
        
        favAction.backgroundColor = UIColor.brown
        
        return [favAction]
    }
    
    func storyboardLoad<T>(_ sceneName:String) -> T {
        return self.storyboard?.instantiateViewController(withIdentifier: sceneName) as! T
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
