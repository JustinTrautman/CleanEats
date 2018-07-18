//
//  HealthRatingTableViewCell.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit


class HealthRatingTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var violationView: UIView!
    @IBOutlet weak var violationViewSubview: UIView!
    
    @IBOutlet weak var criticalViolationsTotal: UILabel!
    @IBOutlet weak var nonCriticalViolationsTotal: UILabel!
    @IBOutlet weak var violationsPointTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        initializeViolationView()
        // Configure the view for the selected state
    }
    
    func initializeViolationView() {
        
        violationView.layer.cornerRadius = 3.0
        violationView.clipsToBounds = true
        violationView.layer.masksToBounds = false
        violationView.layer.shadowRadius = 7.0
        violationView.layer.shadowColor = UIColor.black.cgColor
        violationView.layer.shadowOpacity = 0.4
        violationView.layer.shadowOffset = CGSize.zero
        violationView.layer.shouldRasterize = true
        
        violationViewSubview.layer.masksToBounds = false
        violationViewSubview.layer.cornerRadius = 3
        violationViewSubview.clipsToBounds = true
        self.selectionStyle = .none
        
    }
    // MARK: IBActions
    
    
    
}
// Three steps for child
// Two steps for the parent

