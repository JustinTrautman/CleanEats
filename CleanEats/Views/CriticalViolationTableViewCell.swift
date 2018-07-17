//
//  ViolationTableViewCell.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/14/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class CriticalViolationTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var criticalViolationTotal: UILabel!
    @IBOutlet weak var violationTitleMajor: UILabel!
    @IBOutlet weak var violationCodeMajor: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var points: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
