//
//  HealthRatingTableViewCell.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//
import UIKit

class HealthRatingTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var healthInspection: HealthInspection? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var inspectionDateLabel: UILabel!
    @IBOutlet weak var violationView: UIView!
    @IBOutlet weak var violationViewSubview: UIView!
    @IBOutlet weak var criticalViolationsTotal: UILabel!
    @IBOutlet weak var nonCriticalViolationsTotal: UILabel!
    @IBOutlet weak var otherViolationTotal: UILabel!
    @IBOutlet weak var violationsPointTotal: UILabel!
    
    func updateViews() {
        guard let inspection = healthInspection else {
            return
        }
        
        let inspectionDate = inspection.inspectionDate ?? "Unknown Inspection Date"
        let criticalViolationCount = inspection.criticalViolation ?? 0
        let nonCriticalViolationCount = inspection.nonCriticalViolation ?? 0
        let totalViolations = criticalViolationCount + nonCriticalViolationCount == 0 ? 1 : criticalViolationCount + nonCriticalViolationCount
        
        DispatchQueue.main.async {
            self.inspectionDateLabel.text = inspectionDate
            self.criticalViolationsTotal.text = String(describing: criticalViolationCount)
            self.nonCriticalViolationsTotal.text = String(describing: nonCriticalViolationCount)
            self.otherViolationTotal.text = String(describing: totalViolations)
            self.violationsPointTotal.text = String(describing: totalViolations)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        initializeViolationView()
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
}
