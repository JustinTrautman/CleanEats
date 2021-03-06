//
//  HealthReviewsTableViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class HealthInspectionTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoButton: UIButton!
    
    // MARK: - Properties
    var restaurantDetails: Businesses?
    var healthInspections: [HealthInspection] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if healthInspections.count == 0 {
            tableView.setEmptyMessage("We couldn't find any health inspection records on file for this restuarant. Please see the reviews tab to see more details about this restaurant.")
        }
        
        return healthInspections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "healthViolationCell") as? HealthRatingTableViewCell else { return UITableViewCell() }
        
        let healthData = healthInspections[indexPath.row]
        cell.healthInspection = healthData
        
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
                
                destinationVC.restaurantDetails = restaurantDetails
                destinationVC.healthInspection = selectedInspection
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func infoButtonTapped(_ sender: Any) {
        AlertHelper.showInspectionInformationalAlert(vc: self)
    }
}

