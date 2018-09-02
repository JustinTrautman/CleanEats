//
//  ViolationTableViewCell.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/14/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class CriticalViolationTableViewCell: UITableViewCell {
    
    var numberOfCriticalViolations: Int? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var violationTitleMajor: UILabel!
    @IBOutlet weak var violationCodeMajor: UILabel!
    @IBOutlet weak var criticalViolationCodeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initializeViolationLabels() {
        let attibutedText = NSMutableAttributedString(string: " \(violationTitleMajor)", attributes: nil)
    }
    func updateViews() {
        
        if numberOfCriticalViolations == 0 {
            self.violationTitleMajor.text = "No critical violations"
        }
        self.violationTitleMajor.text = "\(HealthViolationData.shared.violationTitles)"
//        self.criticalViolationCodeLabel.text = "Critical Violation Code: \(violationMockData.violationCode)"
//        self.violationCodeMajor.text = "\(violationMockData.weight) points"
    }
}
