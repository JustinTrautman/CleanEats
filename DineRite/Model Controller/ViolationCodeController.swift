//
//  ViolationCodeController.swift
//  DineRite
//
//  Created by Justin Trautman on 3/17/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation

class ViolationCodeController {
    fileprivate static var violationCodes: [ViolationCode]!
    
    static func serializeViolationCodes() {
        guard let url = Bundle.main.url(forResource: "ViolationCode", withExtension: ".json") else {
            preconditionFailure("Failed to load ViolationCode.json file.")
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let codes = try Data(contentsOf: url)
            let codesDictionary = try jsonDecoder.decode([ViolationCode].self, from: codes)
            self.violationCodes = codesDictionary
        } catch {
            print("Error serializing violation code data. \(error.localizedDescription)")
        }
    }
}
