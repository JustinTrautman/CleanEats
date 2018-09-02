//
//  HealthViolationData.swift
//  CleanEats
//
//  Created by Justin Trautman on 9/1/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation

struct HealthViolationData {
    
    static var shared = HealthViolationData()
    
    var violationTitles: [String]? = []
    var criticalViolations: [Int]? = []
    var nonCriticalViolations: [Int]? = []
    var inspectionDates: [String]? = []
    var violationCodes: [String]? = []
    var violationWeights: [Int]? = []
}
