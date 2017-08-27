//
//  AppointmentsViewController.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/3/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import UIKit
import MessageUI

enum FormArray: Int {
    case name = 0, phone, streetAddress, address2, city, zipCode, email, date, petName, natureOfVisit
}

enum FormType {
    case text, textView, date, phone
}

class FormObject {
    var type: FormType!
    var tag: String!
    
    init (type : FormType, tag : String) {
        self.type = type
        self.tag = tag
    }
}

class AppointmentsViewController: UIViewController {
    
    // -- Outlets --
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableBottom: NSLayoutConstraint!
    
    // -- Vars --
    var formValues: [String] = ["","","","","","","","","",""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        
        if canSendEmail() {
            self.tableView.isHidden = false
        } else {
            //self.tableView.isHidden = true
            showAlertWithMessage(message: "Unfortunately you need an email account setup to request a Mobile Appointment. Please configure an account in Settings and try again.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(AppointmentsViewController.keyboardWillShowNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppointmentsViewController.keyboardWillHideNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if canSendEmail() {
            self.tableView.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}

// MARK: - TableView Delegate Datasource
extension AppointmentsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 9 {
            return 150
        } else if indexPath.row == 10 {
            return 70
        }
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textViewCell", for: indexPath) as! TextViewCell
            cell.titleLbl.text = "Nature of Visit"
            cell.delegate = self
            cell.textFieldDel = self
            cell.message.text = formValues[indexPath.row]
            return cell
        } else if indexPath.row == 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! ButtonCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! TextFieldCell
            cell.textBox.text = formValues[indexPath.row]
            addToolBar(textField: cell.textBox)
            cell.delegate = self
            cell.setupCell(indexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 10 {
            if checkTextFields() {
                sendEmail()
            }
        }
    }
}

// MARK: - TextField Cell Delegate
extension AppointmentsViewController : TextFieldCellDelegate {
    func adjustTableOffset(index : Int) {
        let indexP = IndexPath(row: index, section: 0)
        self.tableView.scrollToRow(at: indexP, at: .bottom, animated: true)
    }
    
    func didEditTextField(text: String, atIndex index: Int) {
        formValues[index] = text
    }
}

// MARK: - TextView Cell Delegate
extension AppointmentsViewController : TextViewCellDelegate {
    
    func didEditTextView(text : String) {
        formValues[FormArray.natureOfVisit.rawValue] = text
    }
}

// MARK: - Submit Button Delegate
extension AppointmentsViewController : SubmitButtonDelegate {
    func didTapSubmit() {
        if checkTextFields() {
            sendEmail()
        }
    }
}

// MARK: - Mail Compose Delegate
extension AppointmentsViewController : MFMailComposeViewControllerDelegate {
    
    func canSendEmail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func sendEmail() {
        if canSendEmail() {
            let mailVc = configuredMailComposeViewController()
            self.present(mailVc, animated: true, completion: nil)
        }
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setToRecipients(["ntmobilevet@gmail.com"])
        mailComposerVC.setSubject("Mobile Vet Appointment for \(formValues[FormArray.date.rawValue])")
        mailComposerVC.setMessageBody(getEmailBody(), isHTML: false)
        return mailComposerVC
    }
}

// MARK: - Helpers
extension AppointmentsViewController {
    
    func checkTextFields() -> Bool {
        print(formValues)
        if formValues[FormArray.phone.rawValue] == "" {
            showAlertWithMessage(message: "Please enter your phone number")
            return false
        }
        if formValues[FormArray.streetAddress.rawValue] == "" {
            showAlertWithMessage(message: "Please enter your street address")
            return false
        }
        if formValues[FormArray.city.rawValue] == "" {
            showAlertWithMessage(message: "Please enter your city")
            return false
        }
        if formValues[FormArray.zipCode.rawValue] == "" {
            showAlertWithMessage(message: "Please enter your zip code")
            return false
        }
        if formValues[FormArray.email.rawValue] == "" {
            showAlertWithMessage(message: "Please enter your email")
            return false
        }
        if formValues[FormArray.date.rawValue] == "" {
            showAlertWithMessage(message: "Please enter a date for your visit")
            return false
        }
        return true
    }
    
    func textFieldIsEmpty(index : Int) {
        switch index {
        case 1:
            showAlertWithMessage(message: "Please enter your phone number")
        case 2,4,5:
            showAlertWithMessage(message: "Please complete your address")
        case 6:
            showAlertWithMessage(message: "Please enter a date for your visit")
        default:
            break
        }
    }
    
    func showAlertWithMessage(message : String) {
        let alert = CustomAlertView()
        alert.showAlertView(superview: self.view, title: "Mobile Vet", text: message, img:"warning")
    }
}

// MARK: - Email Body
extension AppointmentsViewController {
    
    func getEmailBody() -> String {
//        var nameEmpty = true
//        var address2Empty = true
//        var petNameEmpty = true
//        var natureEmpty = true
//        if formValues[FormArray.name.rawValue] != "" {
//            nameEmpty = false
//        }
//        if formValues[FormArray.address2.rawValue] != "" {
//            address2Empty = false
//        }
//        if formValues[FormArray.petName.rawValue] != "" {
//            petNameEmpty = false
//        }
//        if formValues[FormArray.natureOfVisit.rawValue] != "" {
//            natureEmpty = false
//        }
//        return ""
        if formValues[FormArray.name.rawValue] == "" {
            formValues[FormArray.name.rawValue] = "N/A"
        }
        if formValues[FormArray.address2.rawValue] == "" {
            formValues[FormArray.address2.rawValue] = "N/A"
        }
        if formValues[FormArray.petName.rawValue] == "" {
            formValues[FormArray.petName.rawValue] = "N/A"
        }
        if formValues[FormArray.natureOfVisit.rawValue] == "" {
            formValues[FormArray.natureOfVisit.rawValue] = "N/A"
        }
        return "Dr. Swanton-Vinson,\n\nI would like to request an appointment on \(formValues[FormArray.date.rawValue]).\n\nMy Information\n\nName: \(formValues[FormArray.name.rawValue])\nAddress: \(formValues[FormArray.streetAddress.rawValue])\nAddress Line 2: \(formValues[FormArray.address2.rawValue])\nCity: \(formValues[FormArray.city.rawValue])\nZIP Code: \(formValues[FormArray.zipCode.rawValue])\nEmail: \(formValues[FormArray.email.rawValue])\nPet Name: \(formValues[FormArray.petName.rawValue])\nNature of Visit: \(formValues[FormArray.natureOfVisit.rawValue])\n\nThank you."
     
    }
    
    func returnEverything() -> String {
        return ""
    }
    
    func returnNoName() -> String {
        return ""
    }
    
    func returnNoAddress2() -> String {
        return ""
    }
    
    func returnNoPetName() -> String {
        return ""
    }
    
    func returnNoNature() -> String {
        return ""
    }
}



















