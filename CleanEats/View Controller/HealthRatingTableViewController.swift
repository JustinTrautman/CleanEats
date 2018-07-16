//
//  HealthReviewsTableViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class HealthRatingTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "healthViolationCell") as? HealthRatingTableViewCell else { return  UITableViewCell() }
        
        

        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        }
    
    

//
//    // MARK: - Navigation
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toDetailVC" {
//            guard let destinationVC = segue.destination,
//                let indexPath = tableView.indexPathForSelectedRow else { return }
//            // Finish once data is available
//
//        }
//
//    }
//
//

    

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



