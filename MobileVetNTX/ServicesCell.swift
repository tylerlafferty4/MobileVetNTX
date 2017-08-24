//
//  ServicesCell.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 8/23/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class ServicesCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    var isExpanded:Bool = false {
        didSet {
            if !isExpanded {
                self.textViewHeightConstraint.constant = 0.0
            } else {
                self.textViewHeightConstraint.constant = 121
            }
        }
    }
    
}
