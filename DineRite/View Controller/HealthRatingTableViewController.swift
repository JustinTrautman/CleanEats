//
//  HealthReviewsTableViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class HealthRatingTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoButton: UIButton!
    
    // MARK: - Properties
    var restaurants: Businesses?
    var healthInspections: [HealthInspection] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        listenForHealthInspections()
    }
    
    func listenForHealthInspections() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleInspectionReceival(notification:)), name: Constants.healthInspectionKey, object: nil)
    }
    
    @objc func handleInspectionReceival(notification: NSNotification) {
        guard let healthInspections = notification.userInfo?["inspections"] as? [HealthInspection] else { return }
        print(healthInspections)
        
        self.healthInspections = healthInspections
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthInspections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "healthViolationCell") as? HealthRatingTableViewCell else { return UITableViewCell() }
        
        let healthData = healthInspections[indexPath.row]
        let criticalViolationTotal = Int(healthData.critical ?? "") ?? 0
        let nonCriticalViolationTotal = Int(healthData.nonCritical ?? "") ?? 0
        let totalViolations = criticalViolationTotal + nonCriticalViolationTotal
        
        cell.inspectionDateLabel.text = healthData.inspectionDate?.convertFromExcelDate()
        cell.criticalViolationsTotal.text = String(criticalViolationTotal)
        cell.nonCriticalViolationsTotal.text = String(nonCriticalViolationTotal)
        cell.violationsPointTotal.text = String(totalViolations)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == ViolationDetailViewController.segueIdentifier {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? ViolationDetailViewController else { return }
                
                let selectedInspection = healthInspections[indexPath.row]
                
                destinationVC.healthInspection = selectedInspection
            }
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
