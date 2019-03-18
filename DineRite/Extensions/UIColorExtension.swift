//
//  UIColorExtension.swift
//  DineRite
//
//  Created by Justin Trautman on 3/10/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

extension UIColor {
    class var highestRiskViolation: UIColor {
        return UIColor(displayP3Red: 1.00, green: 0.00, blue: 0.00, alpha: 1.0)
    }
    
    class var moderateRiskViolation: UIColor {
        return UIColor(displayP3Red: 1.00, green: 0.77, blue: 0.31, alpha: 1.0)
    }
    
    class var lowestRiskViolation: UIColor {
        return UIColor(displayP3Red: 0.26, green: 0.43, blue: 0.74, alpha: 1.0)
    }
}
