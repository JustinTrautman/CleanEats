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
    
    @IBOutlet weak var criticalViolationStackView: UIStackView!
    @IBOutlet weak var nonCriticalViolationStackView: UIStackView!
    @IBOutlet weak var violationTableViewController: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


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


/*extension  ViolationDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
//        if section == 0 {
//            return 1//array
//        } else if section == 1 {
//            return 2//array
//        }
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "criticalViolationCell", for: indexPath)
        
        switch(indexPath.section) {
        case 0 : return " \(criticalViolationStackView)"
        case 1 : return " \(nonCriticalViolationStackView)"
        default : return ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        }
    
    }
}
 */


