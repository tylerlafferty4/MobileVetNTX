//
//  TextFieldCell.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/3/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class TextFieldCell : UITableViewCell {
    
    // -- Outlets --
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var textBox: UITextField!
    
    func setupCell(indexPath : IndexPath) {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        textBox.keyboardType = .default
        switch indexPath.row {
        case 0:
            titleLbl.text = "Name *"
        case 1:
            titleLbl.text = "Phone *"
            textBox.keyboardType = .phonePad
        case 2:
            titleLbl.text = "Street Address *"
        case 3:
            titleLbl.text = "Address Line 2"
        case 4:
            titleLbl.text = "City *"
        case 5:
            titleLbl.text = "ZIP Code *"
            textBox.keyboardType = .numberPad
        case 7:
            titleLbl.text = "Date *"
        case 8:
            titleLbl.text = "Pet Name *"
        default:
            break
        }
    }
}
