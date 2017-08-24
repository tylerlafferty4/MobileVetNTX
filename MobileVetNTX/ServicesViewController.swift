//
//  ServicesViewController.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/3/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class ServicesViewController : UIViewController {
    
    // Outlets
    @IBOutlet var tableView: UITableView!
    
    var expandedRows = Set<Int>()
    
    var titleArray: [String] = ["Wellness/Preventive Care", "Cold Laser Therapy", "In-House Bloodwork", "Home Hospice/Euthanasia", "Mobile X-Rays", "Ultrasonogrophy", "Mobile Surgery", "Mobile Dentistry", "Special Events", "Emergencies"]
    var descArray: [String] = ["We strive to provide more years with your pet and your furry family members by offering the best in preventative medicine and wellness care. Not only are vaccinations important for preventing disease, but also early disease screening, heartworm and parasite prevention. We offer prophylactic dental cleanings, and have access to a full in house lab and an external lab that can do all health screening and testing.",
                               "Cold Laser is a state-of-the-art alternative therapy to assist with pain and healing. It can be used after surgeries to help increase blood flow to local areas, improving healing. It can also be used for chronic pain, helping to increase blood flow to those areas. Ask us how your pet would benefit from our Cold Laser Therapy.",
                               "Our in-house laboratory allows us to perform an array of diagnostic tests that help us care for your pet. This ranges from simple laboratory tests to more complex diagnostic tools that help us in treating your pet. Call us today to find out more about our facilities and how we are dedicated to providing care for your pet.",
                               "For those moments that no pet owner wants to think about but is the inevitable. We offer private, low stress and compassionate Euthanasia services. Perfect for those pets that are unable to stand anymore, or those that get stressed/painful in the car. We know how important the comfort and well being of your beloved pet is especially at this time. Cremation and Burial services are available.",
                               "Something unique to this Mobile Veterinary Clinic is the access to Digital X-Ray and the information that X-rays provide. We can detect chest abnormalities, abdominal abnormalities, orthopedic injuries, fractures, foreign bodies, bone cancer, and we can provide OFA hip and elbow X rays, screen for number and size of puppies, the sky’s the limit!!",
                               "We are so proud to offer this service to our clients. This technology helps us diagnose tough abdominal cases, helps us diagnose cancer, bladder abnormalities and also helps us diagnose pregnancy.",
                               "We are proud to offer surgical services to our clients in our own seperate surgical suite. Spays and neuters, C-Sections, mass removals and other minor soft tissue surgeries available. Safe modern anesthesia used, appropriate protocols for the age of the patient, appropriate monitoring and quick recovery is our goal. Gas anesthesia and monitoring used in every procedure and pre-surgical labwork additional pain meds, and E collars are required for each surgery. We do not scrimp on safety and quality of care.",
                               "Mobile Veterinary Clinic of North Texas comes to your door fully equipped to do Dental procedures including ultrasonic scaling, dental extractions, polishing and flouride treamtents. If your pet needs a prophylactic dental cleaning to prevent disease of the kidneys and heart we can schedule it for you. All dentals require pre-anesthetic bloodwork, and if needed will go home with appropriate pain medications and antibiotics.",
                               "Do you have a Special Event that will need Veterinary services? Do you and and few of your friends have several pets/animals that need things done? Want to organize a feral cat spay and neuter event?? We offer a service for those clients that want to get several people together in underserved areas (or out of our normal travel area) that need veterinary attention. We will schedule the events on weekends to better serve these areas. Depending on the size and number we can open it up to a Saturday AND Sunday event if the need arises.",
                               "We are unable to offer after hours emergency services anymore due to large service area we provide services to. If your pet has an emergency please seek a local 24 hour emergency care clinic for afterhours care."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - TableView Delegate Datasource
extension ServicesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicesCell", for: indexPath) as! ServicesCell
        cell.titleLbl.text = titleArray[indexPath.row]
        cell.descTextView.text = descArray[indexPath.row]
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ServicesCell else {
            return
        }
        
        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        
        cell.isExpanded = !cell.isExpanded
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
