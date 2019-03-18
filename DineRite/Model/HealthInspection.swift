//
//  Inspection.swift
//  DineRite
//
//  Created by Justin Trautman on 3/17/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation

struct HealthInspection: Codable {
    let criticalViolation: Int?
    let nonCriticalViolation: Int?
    let weight: Int?
    let phone: String?
    let violationTitle: String?
    let inspectionDate: String?
    let violationCode: String?
    
    init(criticalViolation: Int?, nonCriticalViolation: Int?, weight: Int?, phone: String?, violationTitle: String?, inspectionDate: String?, violationCode: String?) {
        
        self.criticalViolation = criticalViolation
        self.nonCriticalViolation = nonCriticalViolation
        self.weight = weight
        self.phone = phone
        self.violationTitle = violationTitle
        self.inspectionDate = inspectionDate
        self.violationCode = violationCode
    }
    
    private enum codingKey: String, CodingKey {
        case criticalViolation = "major"
        case nonCriticalViolation = "minor"
        case weight, phone, violationTitle, inspectionDate, violationCode
    }
}
