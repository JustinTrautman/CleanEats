//
//  InspectionController.swift
//  DineRite
//
//  Created by Justin Trautman on 3/17/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation

struct HealthInspectionController {
    fileprivate static var healthInspections: [String: [HealthInspection]] = [:]
    fileprivate static var matchingInspections: [HealthInspection] = []
    
    static func serializeHealthInspections() {
        guard let url = Bundle.main.url(forResource: "Inspection", withExtension: ".json") else {
            fatalError("Could not load Inspection.json file")
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let inspections = try Data(contentsOf: url)
            let inspectionDictionary = try jsonDecoder.decode([String: [HealthInspection]].self, from: inspections)
            self.healthInspections = inspectionDictionary
        } catch {
            print("Error serializing health inspections. \(error.localizedDescription)")
        }
    }
    
    static func getHealthInspectionsFor(address: String, completion: @escaping([HealthInspection]?) -> Void) {
        let searchTerm = address.truncate(endingCharacter: ",")
        for inspection in self.healthInspections {
            if inspection.key.contains(searchTerm) {
                inspection.value.forEach { (inspection) in
                    matchingInspections.append(inspection)
                }
                completion(matchingInspections)
            }
        }
    }
}

