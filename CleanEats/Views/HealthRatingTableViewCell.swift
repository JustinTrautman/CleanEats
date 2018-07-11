//
//  HealthRatingTableViewCell.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

protocol healthRatingTableViewCellDelegate: class {
    func infoButtonTapped(cell: HealthRatingTableViewCell)
}

class HealthRatingTableViewCell: UITableViewCell {
    
    weak var cellDelegate: healthRatingTableViewCellDelegate?
    // MARK: IBOutlets
    
 
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var violationView: UIView!
    @IBOutlet weak var violationViewSubview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        initializeViolationView()
        // Configure the view for the selected state
    }
    
    func initializeViolationView() {
        // Find Food Button
        violationView.layer.cornerRadius = 3.0
        violationView.clipsToBounds = false
        
        violationView.layer.shadowRadius = 7.0
        violationView.layer.shadowColor = UIColor.black.cgColor
        violationView.layer.shadowOpacity = 0.4
        violationView.layer.shadowOffset = CGSize.zero
        violationView.layer.masksToBounds = false
        violationView.layer.shouldRasterize = true
        violationViewSubview.layer.masksToBounds = false
        violationViewSubview.layer.cornerRadius = 3

    }
    
    // MARK: IBActions
    

    @IBAction func infoButtonTapped(_ sender: Any) {
        print("infoButtonTapped")
        cellDelegate?.infoButtonTapped(cell: self)
        let violationsAlert = UIAlertController(title: "Critical Violation", message: "This is an alert.", preferredStyle: .alert)
        violationsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        //present(violationsAlert, animated: true, completion: nil)
    }
}
    

