//
//  HealthInspection.swift
//  DineRite
//
//  Created by Justin Trautman on 3/4/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation

struct HealthInspection: Codable {
    let name: String
    let address: String
    let city: String
    let zip: String
    let phone: String?
    let inspectionDate: String?
    let violationCode: String?
    let violationTitle: String?
    let points: String?
    let critical: String?
    let nonCritical: String?
}
