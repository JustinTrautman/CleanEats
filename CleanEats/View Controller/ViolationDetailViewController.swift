//
//  ViolationDetailViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/13/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class ViolationDetailViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {
    
    // MARK: - Properties
    var violationTitles = HealthViolationData.shared.violationTitles
    var criticalViolations = HealthViolationData.shared.criticalViolations
    var nonCriticalViolations = HealthViolationData.shared.nonCriticalViolations
    var inspectionDates = HealthViolationData.shared.inspectionDates
    var violationCodes = HealthViolationData.shared.violationCodes
    var violationWeights = HealthViolationData.shared.violationWeights
    
    // MARK:  IBOutlets
    @IBOutlet weak var violationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        violationTableView.dataSource = self
        violationTableView.delegate = self
        violationTableView.bounces = false
        violationTableView.tableFooterView = UIView()
    }
    
    func splitBetweenMajorAndMinor(_ input: [Violation]) -> (major: [Violation], minor: [Violation]) {
        // USE THE .filter() method
        return([], [])
    }
}

extension  ViolationDetailViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard var violations = violationTitles else { return 0 }
          print(violations.removeDuplicates())
        return violations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard var violationTitle = violationTitles else { return UITableViewCell() }
        violationTitle.removeDuplicates()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "criticalViolationCell", for: indexPath) as! CriticalViolationTableViewCell
        
        let violationData = violationTitle[indexPath.row]
        
        cell.numberOfCriticalViolations = violationData.count
        cell.violationTitleMajor.text = "\(violationTitle)"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let violationBoldText = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17)]
        let violationTitleText = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)]
        
        guard let criticalViolationTotal = HealthViolationData.shared.criticalViolations,
        let nonCriticalViolationTotal = HealthViolationData.shared.nonCriticalViolations else { return UIView() }
        
        if section == 0 {
            
            let headerOneView = UIView()
            let criticalViolationsLabel = UILabel()
            
            headerOneView.addSubview(criticalViolationsLabel)
            headerOneView.backgroundColor? = .white
            
            criticalViolationsLabel.translatesAutoresizingMaskIntoConstraints = false
            criticalViolationsLabel.centerXAnchor.constraint(equalTo: headerOneView.centerXAnchor, constant: 0).isActive = true
            criticalViolationsLabel.centerYAnchor.constraint(equalTo: headerOneView.centerYAnchor, constant: 0).isActive = true
            //            criticalViolationsLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: 0).isActive = true
            
            let attributedText = NSMutableAttributedString(string: "Critical Violations", attributes: violationBoldText)
            attributedText.append(NSAttributedString(string: "  \(criticalViolationTotal.count)", attributes: [ // Put your model object major violations where 99 is
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
            
            attributedText.append(NSAttributedString(string: "  \(nonCriticalViolationTotal.count)", attributes: [ // Put your model object major violations where 99 is
                NSAttributedStringKey.foregroundColor : UIColor.red]))
            
            nonCriticalViolationsLabel.attributedText = attributedText
            
            return headerTwoView
            
        } else {
            
            return nil
        }
    }
}
