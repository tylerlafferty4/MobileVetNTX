//
//  TextViewCell.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/5/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

protocol TextViewCellDelegate {
    func didEditTextView(text : String)
}
class TextViewCell : UITableViewCell, UITextViewDelegate {
    
    // -- Outlets --
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var message: UITextView!
    var index: Int!
    var delegate: TextViewCellDelegate!
    var textFieldDel: TextFieldCellDelegate!
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor.black.cgColor
        message.delegate = self
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let del = delegate {
            del.didEditTextView(text: textView.text)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let del = textFieldDel {
            del.adjustTableOffset(index: index)
        }
    }
}
