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
    func adjustTableOffset(index : Int)
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
        textBox.delegate = self
    }

    @IBAction func textFieldEditing(_ sender: UITextField) {
        if sender.tag == 7 {
            let datePickerView:UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.date
            sender.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(TextFieldCell.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.textBox.text = dateFormatter.string(from: sender.date)
        if let del = delegate {
            del.didEditTextField(text: dateFormatter.string(from: sender.date), atIndex: FormArray.date.rawValue)
        }
    }
    
    func setupContactUs(indexPath : IndexPath) {
        index = indexPath.row
        textBox.keyboardType = .default
        textBox.tag = indexPath.row
        textBox.delegate = self
        switch indexPath.row {
        case 0:
            titleLbl.text = "Name *"
        case 1:
            titleLbl.text = "Phone *"
            textBox.keyboardType = .numberPad
        case 2:
            titleLbl.text = "Email *"
            textBox.keyboardType = .emailAddress
        default:
            titleLbl.text = ""
        }
    }
    
    func setupCell(indexPath : IndexPath) {
        index = indexPath.row
        textBox.keyboardType = .default
        textBox.tag = indexPath.row
        textBox.delegate = self
        switch indexPath.row {
        case 0:
            titleLbl.text = "Name"
        case 1:
            titleLbl.text = "Phone *"
            textBox.keyboardType = .numberPad
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let del = delegate {
            del.adjustTableOffset(index: index)
        }
    }
    
    func textFieldDidEndEditing(_ textField : UITextField) {
        // call back with the delegate here
        if let del = delegate {
            del.didEditTextField(text: textField.text!, atIndex: self.index)
        }
    }
}
