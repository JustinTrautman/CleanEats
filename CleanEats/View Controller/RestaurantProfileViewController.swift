//
//  RestaurantProfileViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class RestaurantProfileViewController: UIViewController {

    // MARK: - IBActions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            aboutContainerView.isHidden = false
            healthRatingContainerView.isHidden = true
            reviewContainerView.isHidden = true
        case 1:
            healthRatingContainerView.isHidden = false
            aboutContainerView.isHidden = true
            reviewContainerView.isHidden = true
        case 2:
            healthRatingContainerView.isHidden = true
            aboutContainerView.isHidden = true
            reviewContainerView.isHidden = false
            
        default:
            break
        }
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var aboutContainerView: UIView!
    @IBOutlet weak var healthRatingContainerView: UIView!
    @IBOutlet weak var reviewContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
