

//
//  File.swift
//  CleanEats
//
//  Created by Joshua Danner on 8/2/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation

class ViolationMockData {
    
    var violationTitle: String
    var violationCode: String
    var weight: Int
    
    init(violationTitle: String, violationCode: String, weight: Int) {
        
        self.violationTitle = violationTitle
        self.violationCode = violationCode
        self.weight = weight
    }
    
}
class MockDataController {
    
    static let shared = MockDataController()
    
    var mockData: [ViolationMockData] {
        let mockData = [
            ViolationMockData(violationTitle: "Eating, Drinking, or Using Tobacco**", violationCode: "4.2.18**", weight: 3),
            ViolationMockData(violationTitle: "Hair Restraint Effectiveness", violationCode: "4.2.20", weight: 1),
            ViolationMockData(violationTitle: "Preventing Contamination from Hands*", violationCode: "4.3.21*", weight: 6),
            ViolationMockData(violationTitle: "Equipment, Food-Contact Surfaces, Nonfood-Contact Surf", violationCode: "4.4.82*", weight: 6),
            ViolationMockData(violationTitle: "Nonfood-Contact Surfaces-Cleaning", violationCode: "4.4.85", weight: 1),
            ViolationMockData(violationTitle: "Food Safety Manager Certification", violationCode: "4.1.4 (i)", weight: 6)
        ]
        return mockData
    }
    
}





