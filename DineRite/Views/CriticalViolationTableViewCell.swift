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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViews() {
    }
}
