//
//  AppointmentsViewController.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/3/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import UIKit

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
    @IBOutlet var webView: UIWebView!

}
    
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
