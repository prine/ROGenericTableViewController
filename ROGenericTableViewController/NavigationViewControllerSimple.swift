//
//  NavigationViewController.swift
//  ROTableViewController
//
//  Created by Robin Oster on 27/03/15.
//  Copyright (c) 2015 Rascor International AG. All rights reserved.
//

import UIKit


class Company {
    var name:String = ""
    var amountWorkers:Int = 0
    
    init(_ name:String, _ amountWorkers:Int) {
        self.name = name
        self.amountWorkers = amountWorkers
    }
}

class NavigationViewControllerSimple: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var glencore = Company("Glencore", 10000)
        var nestle = Company("Nestle", 80011)
        
        var cellForRow = ({ (tableView:UITableView, company:Company) -> UITableViewCell in
            // CellForRowAtIndexPath
            var customCell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell?
            
            if customCell == nil {
                customCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell") as UITableViewCell
            }
            
            customCell!.textLabel?.text = company.name
            customCell!.detailTextLabel?.text = "Amount of workers: \(company.amountWorkers)"
            
            return customCell!
        })
        
        var didCellSelect = ({(company:Company) -> () in
            println("Company: \(company.name) got selected")
        })
        
        // Generic CustomTableViewCell solution
        var tableViewController = createViewControllerGeneric([nestle, glencore], cellForRow, didCellSelect) as! ROGenericTableViewController
        
        tableViewController.swipeActions = createSwipeActions()
        
        self.viewControllers = [tableViewController]
    }
    
    func createSwipeActions() -> [UITableViewRowAction] {
        var favAction = UITableViewRowAction(style: .Normal, title: "Fire all employees") { (action, indexPath) -> Void in
            println("Fire everyone from the company")
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
