//
//  TextFieldCell.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/3/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

protocol TextFieldCellDelegate {
    func didEditTextField(text : String, atIndex : Int)
}

class TextFieldCell : UITableViewCell, UITextFieldDelegate {
    
    // -- Outlets --
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var textBox: UITextField!
    
    var delegate: TextFieldCellDelegate!
    var index: Int! = 0
    
    override func awakeFromNib() {
        textBox.delegate = self
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
    
    func setupCell(indexPath : IndexPath) {
        textBox.keyboardType = .default
        switch indexPath.row {
        case 0:
            titleLbl.text = "Name"
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
        case 6:
            titleLbl.text = "Email *"
            textBox.keyboardType = .emailAddress
        case 7:
            titleLbl.text = "Date *"
        case 8:
            titleLbl.text = "Pet Name"
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField : UITextField) {
        // call back with the delegate here
        if let del = delegate {
            del.didEditTextField(text: textField.text!, atIndex: self.index)
        }
    }
}
