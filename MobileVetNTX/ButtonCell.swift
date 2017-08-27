//
//  ButtonCell.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/5/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

protocol SubmitButtonDelegate {
    func didTapSubmit()
}

class ButtonCell : UITableViewCell {
    
    // -- Outlets --
    @IBOutlet var submitBtn: UIButton!
    var delegate: SubmitButtonDelegate!
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        submitBtn.layer.cornerRadius = 3
    }
    @IBAction func submitTapped(_ sender: UIButton) {
        if let del = delegate {
            del.didTapSubmit()
        }
    }
}
