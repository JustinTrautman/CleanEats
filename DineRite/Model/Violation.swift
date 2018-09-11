//
//  Violation.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/17/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation

// Health Violation Data

class Violation: Codable {
    let criticalViolation: Int?
    let nonCriticalViolation: Int?
    let weight: Int?
    let violationTitle: String?
    let inspectionDate: String?
    let violationCode: String?
    
    init(criticalViolation: Int?, nonCriticalViolation: Int?, weight: Int?, violationTitle: String?, inspectionDate: String?, violationCode: String?) {
        
        self.criticalViolation = criticalViolation
        self.nonCriticalViolation = nonCriticalViolation
        self.weight = weight
        self.violationTitle = violationTitle
        self.inspectionDate = inspectionDate
        self.violationCode = violationCode
    }
    
    private enum codingKey: String, CodingKey {
        
        case criticalViolation = "major"
        case nonCriticalViolation = "minor"
        case weight
        case violationTitle
        case inspectionDate
        case violationCode
    }
}
