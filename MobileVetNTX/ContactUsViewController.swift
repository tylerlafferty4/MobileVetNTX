//
//  ContactUsViewController.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/3/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class ContactUsViewController : UIViewController {
    
    // -- Outlets --
    @IBOutlet var containerView: UIView!
    @IBOutlet var infoView: UIView!
    @IBOutlet var hoursView: UIView!
    @IBOutlet var weekendHours: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableBottom: NSLayoutConstraint!
    
    var values: [String] = ["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        weekendHours.adjustsFontSizeToFitWidth = true
        infoView.layer.cornerRadius = 3
        hoursView.layer.cornerRadius = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ContactUsViewController.keyboardWillShowNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ContactUsViewController.keyboardWillHideNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func keyboardWillShowNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
    }
    
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIViewAnimationOptions.init(rawValue: UInt(rawAnimationCurve))
        if convertedKeyboardEndFrame.minY < 550 {
            tableBottom.constant = view.bounds.maxY - convertedKeyboardEndFrame.minY - 45
        } else {
            tableBottom.constant = view.bounds.maxY - convertedKeyboardEndFrame.minY
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func phoneNumberTapped(_ sender: Any) {
        let phone = URL(string: "tel:19409900862")
        if UIApplication.shared.canOpenURL(phone!) {
            UIApplication.shared.open(phone!, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func showHours(_ sender: Any) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: infoView, duration: 1.0, options: transitionOptions, animations: {
            self.infoView.isHidden = true
        })
        
        UIView.transition(with: hoursView, duration: 1.0, options: transitionOptions, animations: {
            self.hoursView.isHidden = false
        })
        //UIView.transition(from: infoView, to: hoursView, duration: 1, options: .transitionFlipFromRight, completion: nil)
    }
    
    @IBAction func backToInfo(_ sender: Any) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
        UIView.transition(with: hoursView, duration: 1.0, options: transitionOptions, animations: {
            self.hoursView.isHidden = true
        })
        
        UIView.transition(with: infoView, duration: 1.0, options: transitionOptions, animations: {
            self.infoView.isHidden = false
        })
    }
}

// MARK: - TableView Delegate Datasource
extension ContactUsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 70
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! ButtonCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! TextFieldCell
            switch indexPath.row {
            case 0:
                cell.titleLbl.text = "Name *"
            case 1:
                cell.titleLbl.text = "Phone *"
            case 2:
                cell.titleLbl.text = "Email *"
            default:
                cell.titleLbl.text = ""
            }
            cell.delegate = self
            cell.index = indexPath.row
            addToolBar(textField: cell.textBox)
            cell.textBox.tag = indexPath.row
            cell.textBox.text = values[indexPath.row]
            return cell
        }
    }
}

// MARK: - TextFieldCell Delegate
extension ContactUsViewController : TextFieldCellDelegate {
    
    func adjustTableOffset(index: Int) {
        let indexP = IndexPath(row: index, section: 0)
        //self.tableView.scrollToRow(at: indexP, at: .bottom, animated: true)
    }
    
    func didEditTextField(text: String, atIndex: Int) {
        values[atIndex] = text
    }
}

// MARK: - Submit Button Delegate
extension ContactUsViewController : SubmitButtonDelegate {
    
    func didTapSubmit() {
        print(values)
    }
}













