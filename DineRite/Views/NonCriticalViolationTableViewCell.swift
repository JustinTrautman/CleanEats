//
//  NonCriticalTableViewCell.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/14/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class NonCriticalViolationTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var nonCriticalViolationTotal: UILabel!
    @IBOutlet weak var violationTitleMinor: UILabel!
    @IBOutlet weak var violationCodeMinor: UILabel!
    @IBOutlet weak var points: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
