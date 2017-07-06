//
//  AppointmentsViewController.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/3/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import UIKit
import Eureka

class AppointmentsViewController: FormViewController {
    
    @IBOutlet var submitBtn: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitBtn.layer.cornerRadius = 3
        
        LabelRow.defaultCellUpdate = { cell, row in
            cell.contentView.backgroundColor = .red
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            cell.textLabel?.textAlignment = .right
            
        }
        
        TextRow.defaultCellUpdate = { cell, row in
            cell.backgroundColor = UIColor.groupTableViewBackground
            cell.titleLabel?.textColor = .black
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        
        PhoneRow.defaultCellUpdate = { cell, row in
            cell.backgroundColor = UIColor.groupTableViewBackground
            cell.titleLabel?.textColor = .black
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        
        DateInlineRow.defaultCellUpdate = { cell, row in
            cell.backgroundColor = UIColor.groupTableViewBackground
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
        
        TextAreaRow.defaultCellUpdate = { cell, row in
            cell.backgroundColor = UIColor.groupTableViewBackground
        }
        
        ButtonRow.defaultCellUpdate = { cell, row in
            cell.backgroundColor = .blue
        }
        
        form +++ Section("")
            <<< TextRow("name"){
                $0.title = "Name"
                $0.add(rule: RuleRequired())
                $0.placeholder = "John Doe"
                $0.validationOptions = .validatesOnChange
            }
            <<< PhoneRow("phoneNumber"){
                $0.add(rule: RuleRequired())
                $0.title = "Phone Number"
                $0.add(rule: RuleMinLength(minLength: 10))
                $0.add(rule: RuleMaxLength(maxLength: 10))
                $0.placeholder = "1234567890"
                $0.validationOptions = .validatesOnBlur
            }
            <<< TextRow("streetAdress"){
                $0.add(rule: RuleRequired())
                $0.title = "Street Address"
                $0.placeholder = "1234 Cherry Ln"
                $0.validationOptions = .validatesOnBlur
            }
            <<< TextRow("addressTwo"){
                $0.add(rule: RuleRequired())
                $0.title = "Address Line 2"
                $0.placeholder = "APT #, Unit #, etc"
                $0.validationOptions = .validatesOnBlur
            }
            <<< TextRow("city"){
                $0.add(rule: RuleRequired())
                $0.title = "City"
                $0.placeholder = "Enter City Here"
                $0.validationOptions = .validatesOnBlur
            }
            <<< PhoneRow("zipCode"){
                $0.add(rule: RuleRequired())
                $0.title = "Zip Code"
                $0.add(rule: RuleMinLength(minLength: 5))
                $0.add(rule: RuleMaxLength(maxLength: 5))
                $0.placeholder = "Enter Zip Code Here"
                $0.validationOptions = .validatesOnBlur
            }
            <<< DateInlineRow("date"){
                $0.add(rule: RuleRequired())
                $0.title = "Date"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
                $0.validationOptions = .validatesOnBlur
            }
            <<< TextRow("petName"){
                $0.add(rule: RuleRequired())
                $0.title = "Pet Name"
                $0.placeholder = "Enter Pet Name Here"
                $0.validationOptions = .validatesOnBlur
            }
            <<< TextAreaRow("nature"){
                $0.add(rule: RuleRequired())
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
                $0.placeholder = "Enter nature of visit here"
                $0.validationOptions = .validatesOnBlur
            }
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        let row: TextRow? = form.rowBy(tag: "name")
        if row?.isValid == true {
            print("Valid")
        } else {
            print("Invalid")
        }
    }
}

////UIViewController {
//    
//    // -- Outlets --
//    @IBOutlet var tableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.hideKeyboardWhenTappedAround()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//}
//
//// MARK: - TableView Delegate Datasource
//extension AppointmentsViewController : UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 9 {
//            return 150
//        } else if indexPath.row == 10 {
//            return 70
//        }
//        return 100
//    }
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 11
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 9 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "textViewCell", for: indexPath) as! TextViewCell
//            cell.titleLbl.text = "Nature of Visit *"
//            return cell
//        } else if indexPath.row == 10 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! ButtonCell
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! TextFieldCell
//            cell.setupCell(indexPath: indexPath)
//            return cell
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 10 {
//            checkTextFields()
//        }
//    }
//}
//
//// MARK: - Helpers
//extension AppointmentsViewController {
//    
//    func checkTextFields() {
//        for x in 0...9 {
//            if x == 9 {
//                let cell = tableView.cellForRow(at: IndexPath(row: x, section: 0)) as! TextViewCell
//                if cell.message.text == "" {
//                    textFieldIsEmpty(index: x)
//                    return
//                }
//            }
//            if x != 3 {
//                let indexPath = IndexPath(row: x, section: 0)
//                let cell = tableView.cellForRow(at: indexPath) as! TextFieldCell
//                if cell.textBox.text == "" {
//                    textFieldIsEmpty(index: x)
//                    return
//                }
//            }
//        }
//    }
//    
//    func textFieldIsEmpty(index : Int) {
//        switch index {
//        case 0:
//            showAlertWithMessage(message: "Please enter your name")
//        case 1:
//            showAlertWithMessage(message: "Please enter your phone number")
//        case 2,4,5:
//            showAlertWithMessage(message: "Please complete your address")
//        case 6:
//            showAlertWithMessage(message: "Please enter a date for your visit")
//        case 7:
//            showAlertWithMessage(message: "Please enter your Pet's name")
//        case 8:
//            showAlertWithMessage(message: "Please enter the nature of your visit")
//        default:
//            break
//        }
//    }
//    
//    func showAlertWithMessage(message : String) {
//        let alert = UIAlertController(title: "Mobile Vet", message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
//}
//
//
//
//
//
