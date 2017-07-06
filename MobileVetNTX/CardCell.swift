//
//  CardCell.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 10/21/16.
//  Copyright © 2016 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class CardCell: UITableViewCell {

    override func awakeFromNib() {
        layer.cornerRadius = 3
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let mainWidth = UIScreen.main.bounds.width
            if frame.width > mainWidth - 16 {
                frame.origin.y += 8
                frame.size.height -= 16
                frame.origin.x += 8
                frame.size.width -= 16
            }else {
                if frame.origin.x != 8 {
                    frame.origin.x += 8
                }
            }
            super.frame = frame
        }
    }
}
