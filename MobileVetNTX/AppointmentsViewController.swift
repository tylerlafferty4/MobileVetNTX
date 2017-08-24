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
    case name = 0, phone, streetAddress, address2, city, zipCode, email, date, petName
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
    
    // -- Vars --
    var formValues: [String] = ["","","","","","","","",""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        
        if canSendEmail() {
            self.tableView.isHidden = false
        } else {
            self.tableView.isHidden = true
            showAlertWithMessage(message: "Unfortunately you need an email account setup to request a Mobile Appointment. Please configure an account in Settings and try again.")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if canSendEmail() {
            self.tableView.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textViewCell", for: indexPath) as! TextViewCell
            cell.titleLbl.text = "Nature of Visit"
            return cell
        } else if indexPath.row == 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! ButtonCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! TextFieldCell
            cell.index = indexPath.row
            cell.delegate = self
            cell.textBox.text = formValues[indexPath.row]
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
    
    func didEditTextField(text: String, atIndex index: Int) {
        formValues[index] = text
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
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("Mobile Vet Appointment for \(formValues[FormArray.date.rawValue])")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        return mailComposerVC
    }
}

// MARK: - Helpers
extension AppointmentsViewController {
    
    func checkTextFields() -> Bool {
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





