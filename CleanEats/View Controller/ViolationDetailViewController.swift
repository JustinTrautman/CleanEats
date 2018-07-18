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
    

    @IBOutlet weak var violationTableViewController: UITableView!

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
        let violationBoldText = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17)]
        let violationTitleText = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)]
        
        if section == 0 {
            
            let headerOneView = UIView()
            let criticalViolationsLabel = UILabel()
            
            headerOneView.addSubview(criticalViolationsLabel)
            
            criticalViolationsLabel.translatesAutoresizingMaskIntoConstraints = false
            criticalViolationsLabel.centerXAnchor.constraint(equalTo: headerOneView.centerXAnchor, constant: 0).isActive = true
            criticalViolationsLabel.centerYAnchor.constraint(equalTo: headerOneView.centerYAnchor, constant: 0).isActive = true
//            criticalViolationsLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: 0).isActive = true
            
            let attributedText = NSMutableAttributedString(string: "Critical Violations", attributes: violationBoldText)
            attributedText.append(NSAttributedString(string: "  \(99)", attributes: [ // Put your model object major violations where 99 is
                NSAttributedStringKey.foregroundColor : UIColor.red
                ]))
            
            criticalViolationsLabel.attributedText = attributedText
            
            return headerOneView
        } else if section == 1 {
            
            let headerTwoView = UIView()
            let nonCriticalViolationsLabel = UILabel()
            
            headerTwoView.addSubview(nonCriticalViolationsLabel)
            
            nonCriticalViolationsLabel.translatesAutoresizingMaskIntoConstraints = false
            nonCriticalViolationsLabel.centerXAnchor.constraint(equalTo: headerTwoView.centerXAnchor, constant: 0).isActive = true
            nonCriticalViolationsLabel.centerYAnchor.constraint(equalTo: headerTwoView.centerYAnchor, constant: 0).isActive = true
            //            criticalViolationsLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: 0).isActive = true
            
            
            
            let attributedText = NSMutableAttributedString(string: "Non Critical Violations", attributes: violationBoldText)
            
            attributedText.append(NSAttributedString(string: "  \(99999)", attributes: [ // Put your model object major violations where 99 is
                NSAttributedStringKey.foregroundColor : UIColor.red]))
            
            nonCriticalViolationsLabel.attributedText = attributedText
            
            return headerTwoView
            
        } else {
            return nil
        }
    }

}



