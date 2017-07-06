//
//  ButtonCell.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/5/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class ButtonCell : UITableViewCell {
    
    // -- Outlets --
    @IBOutlet var submitBtn: UIButton!
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        submitBtn.layer.cornerRadius = 3
    }
}
