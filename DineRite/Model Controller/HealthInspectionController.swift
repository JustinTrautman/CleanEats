//
//  HealthInspectionController.swift
//  DineRite
//
//  Created by Justin Trautman on 3/4/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation

class HealthInspectionController {
    
    // MARK: Class Properties
    static let databaseUrl = Constants.healthInspectionDatabase
    static let getterEndpoint = databaseUrl?.appendingPathComponent(".json")
    static var healthInspections: [HealthInspection]?
    
    static func fetchHealthInspectionFor(restaurantAddress: String, completion: @escaping([HealthInspection]?) -> Void) {
        let datatask = URLSession.shared.dataTask(with: getterEndpoint!) { (data, _, error) in
            if let error = error {
                assertionFailure("Failed to return resource data. \(error.localizedDescription)")
                completion(nil)
                return
                // TODO: Show user facing error and refresh automatically
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
               let healthInspections = try jsonDecoder.decode([HealthInspection].self, from: data)
                var foundInspections: [HealthInspection] = []
                
                for inspection in healthInspections {
                    if restaurantAddress.contains(inspection.address) {
                        foundInspections.append(inspection)
                        self.healthInspections = foundInspections
                        completion(foundInspections)
                    }
                }                
            } catch {
                fatalError("Error decoding health inspection data. \(error.localizedDescription)")
            }
        }; datatask.resume()
    }
}
