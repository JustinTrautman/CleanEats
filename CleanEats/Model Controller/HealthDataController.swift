//
//  HealthDataController.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/14/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation

class HealthDataController {
    
    static let shared = HealthDataController()
    
    var violationData: [String : [Violation]] = [:]
    
    func serializeHealData() {
        guard let url = Bundle.main.url(forResource: "healthData", withExtension: "json") else { return }
        let jsonDecoder = JSONDecoder()
        
        do {
            
            let healthData = try Data(contentsOf: url)
            let violationsDict = try jsonDecoder.decode([String: [Violation]].self, from: healthData)
            self.violationData = violationsDict
            
        } catch let error {
                print("Error with jsonDecoder decoding json data: \(error) \(error.localizedDescription)")
            }
        }
    
    func getViolationDataWith(searchTerm: String) {
        var keysFound = [String]()
        for key in violationData.keys {
            if key.contains(searchTerm) {
                keysFound.append(key)
            }
        }
    }
}
