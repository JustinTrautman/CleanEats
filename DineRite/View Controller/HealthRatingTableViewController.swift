//
//  HealthReviewsTableViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class HealthRatingTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let shared = HealthRatingTableViewController()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoButton: UIButton!
    
    // MARK: - Properties
    var restaurants: Businesses?
    
    var violationTitles = HealthViolationData.shared.violationTitles
    var criticalViolations = HealthViolationData.shared.criticalViolations
    var nonCriticalViolations = HealthViolationData.shared.nonCriticalViolations
    var inspectionDates = HealthViolationData.shared.inspectionDates
    var violationCodes = HealthViolationData.shared.violationCodes
    var violationWeights = HealthViolationData.shared.violationWeights
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        // Prepares health data for use to speed up parsing
        print("Serializing health data...")
        HealthDataController.shared.serializeHealtData()
        print("Done serializing health data")
        
        fetchHealthData()
    }
    
    func fetchHealthData() {
        guard let searchText = restaurants?.location?.displayAddress[0] else { return }
        let formattedSearchText = searchText.replacingOccurrences(of: "th", with: "").uppercased()
        print(searchText)
        print(formattedSearchText)
        
        HealthDataController.shared.getViolationDataWith(searchTerm: "\(formattedSearchText)") { (violation) in
            violation.forEach {
                // MARK: - Pyramid of if statements and caveman debugging with print statements.
                if let violationTitle = $0.violationTitle {
                    HealthViolationData.shared.violationTitles?.append(violationTitle)
                }
                
                if let criticalViolation = $0.criticalViolation {
                    HealthViolationData.shared.criticalViolations?.append(criticalViolation)
                    self.criticalViolations?.removeDuplicates()
                    //                    print(self.criticalViolations)
                }
                
                if let nonCriticalViolation = $0.nonCriticalViolation {
                    HealthViolationData.shared.nonCriticalViolations?.append(nonCriticalViolation)
                    self.nonCriticalViolations?.removeDuplicates()
                    //                    print(self.nonCriticalViolations)
                }
                
                if let inspectionDate = $0.inspectionDate {
                    HealthViolationData.shared.inspectionDates?.append(inspectionDate)
                    self.inspectionDates?.removeDuplicates()
                    //                    print(self.inspectionDates)
                }
                
                if let violationCode = $0.violationCode {
                    HealthViolationData.shared.violationCodes?.append(violationCode)
                    self.violationCodes?.removeDuplicates()
                    //                    print(self.violationCodes)
                }
                
                if let violationWeight = $0.weight {
                    HealthViolationData.shared.violationWeights?.append(violationWeight)
                    self.violationWeights?.removeDuplicates()
                    //                    print(self.violationWeights)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let inspectionDates = inspectionDates else { return 0 }
        if inspectionDates.count != 0 {
            return 1
        } else {
            return 0
        }
        //        return inspectionDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "healthViolationCell") as? HealthRatingTableViewCell else { return UITableViewCell() }
        
        guard let criticalViolations = criticalViolations,
            let nonCriticalViolations = nonCriticalViolations,
            var inspectionDate = inspectionDates else { return UITableViewCell() }
        
        if inspectionDate.count != 0 {
            let firstInspection = inspectionDate[0]
            
            cell.inspectionDateLabel.text = "\(firstInspection)"
            cell.criticalViolationsTotal.text = "\(criticalViolations.count)"
            cell.nonCriticalViolationsTotal.text = "1"
            //        cell.nonCriticalViolationsTotal.text = "\(nonCriticalViolations.count)"
            cell.violationsPointTotal.text = "1"
            //        cell.violationsPointTotal.text = "\(criticalViolations.count + nonCriticalViolations.count)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toViolationVC" {
            guard let destinationVC = segue.destination as? ViolationDetailViewController else { return }
            
            destinationVC.violationTitles = violationTitles
            //            destinationVC.criticalViolations = criticalViolations
            destinationVC.nonCriticalViolations = nonCriticalViolations
            destinationVC.inspectionDates = inspectionDates
            destinationVC.violationCodes = violationCodes
            destinationVC.violationWeights = violationWeights
        }
    }
    
    // MARK: - IBActions
    @IBAction func infoButtonTapped(_ sender: Any) {
        presentAlert(majorViolation: "Violations of critical food handling practices and conditions, or existence of an environmental health hazard.", minorViolation: "Low risk violations include proper storage of utensils and linens, adequate lighting, lack of refrigerator thermometers, and soiled food contact surfaces.")
    }
}

// Mark: - Alert Stuff
extension HealthRatingTableViewController {
    func presentAlert(majorViolation: String, minorViolation: String) {
        let alert = UIAlertController(title: "Violations", message: "Critical Violations: \n \(majorViolation) \n\n Non-Critical Violations: \n \(minorViolation) \n\n Violation points may be: \n 1(lowest risk violations), \n 3(moderate risk violations), \n or 6 points(highest risk violations).", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(OKAction)
        
        present(alert, animated: true)
    }
}
