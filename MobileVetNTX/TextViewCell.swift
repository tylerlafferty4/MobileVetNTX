//
//  TextViewCell.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/5/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class TextViewCell : UITableViewCell {
    
    // -- Outlets --
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var message: UITextView!
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor.black.cgColor
    }
}
