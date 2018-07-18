//
//  ViolationDetailViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/13/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class ViolationDetailViewController: UIViewController {
    
    // MARK:  IBOutlets
    
    @IBOutlet weak var criticalViolationHeader: UILabel!
    @IBOutlet weak var nonCriticalViolationHeader: UILabel!
    @IBOutlet weak var violationTableViewController: UITableView!
    
    
    @IBOutlet weak var headerOne: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        violationTableViewController.dataSource = self
        violationTableViewController.delegate = self
        
}
    
    func splitBetweenMajorAndMinor(_ input: [Violation]) -> (major: [Violation], minor: [Violation]) {
        // USE THE .filter() method
        return([], [])
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension  ViolationDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2   //array
        } else if section == 1 {
            return 12   //array
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "criticalViolationCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let headerView = UIView()
            let criticalViolationsLabel = UILabel()
            
            headerView.addSubview(criticalViolationsLabel)
            
            criticalViolationsLabel.translatesAutoresizingMaskIntoConstraints = false
            criticalViolationsLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 0).isActive = true
            criticalViolationsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 0).isActive = true
//            criticalViolationsLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: 0).isActive = true
            
            let attributedText = NSMutableAttributedString(string: "Critical Violations", attributes: nil)
            attributedText.append(NSAttributedString(string: "  \(99)", attributes: [ // Put your model object major violations where 99 is
                NSAttributedStringKey.foregroundColor : UIColor.red
                ]))
            
            criticalViolationsLabel.attributedText = attributedText
            
            
            
            
            return headerView
//        } else if section == 1 {
//            return "Non Critical Violation---"
        } else {
            return nil
        }
    }

}



