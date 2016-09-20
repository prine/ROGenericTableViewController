//
//  CustomTableViewCell.swift
//  ROTableViewController
//
//  Created by Robin Oster on 01/04/15.
//  Copyright (c) 2015 Rascor International AG. All rights reserved.
//

import UIKit

class CustomTableViewCell : UITableViewCell {
    
    fileprivate var user:User?
    
    @IBOutlet var firstname:UILabel!
    @IBOutlet var lastname:UILabel!
    @IBOutlet var test:UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setUser(_ user:User) {
        self.user = user
        
        self.firstname?.text = user.firstname
        self.lastname?.text = user.lastname
        
        print("Received user: " + user.firstname + " ~ " + user.lastname)
    }
}
