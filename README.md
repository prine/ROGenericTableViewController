# ROGenericTableViewController
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Issues](https://img.shields.io/github/issues/prine/ROGenericTableViewController.svg?style=flat
)](https://github.com/prine/ROGenericTableViewController/issues)

A generic TableViewController class which is able to deal with custom created objects very easily

## How to use
The usage is really straighforward. Include the ROGenericTableViewController.swift. Instead of implementing the different UITableViewController Delegate methods use the createGenericViewController Method to create a UITableViewController.

Custom created object can be anything. The ROGenericTableViewController class does not need to know which object you are passing.

```Swift
class Company {
    var name:String = ""
    var amountWorkers:Int = 0

    init(_ name:String, _ amountWorkers:Int) {
        self.name = name
        self.amountWorkers = amountWorkers
    }
}
```

This is the whole code which is needed to display a custom created class in a UITableView.
```Swift
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

        var tableViewController = createViewControllerGeneric([nestle, glencore], cellForRow, didCellSelect) as! ROGenericTableViewController

        // Add the swipe actions to the tableViewController
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
```

## License

```
The MIT License (MIT)

Copyright (c) 2015 Robin Oster (http://prine.ch)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

## Author

Robin Oster, robin.oster@rascor.com
