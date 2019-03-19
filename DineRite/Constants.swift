//
//  Constants.swift
//  DineRite
//
//  Created by Justin Trautman on 3/4/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation

struct Constants {
    
    // API Keys
    static let yelpAuthorizationKey = "apikey"
    
    // Databases
    static let healthInspectionDatabase = URL(string: "database")
    
    // Notification Center
    static let healthInspectionKey = Notification.Name("com.dinerite.healthInspection")
    static let reviewUnwindKey = Notification.Name("com.dinerite.reviewUnwind")
    
    // Strings
    static let howHealthScoringWorks = "The score of an establishment inspection is based on the violation points accumulated during a routine inspection. The lower the score the better the inspection and the better the ranking. \nRegardless of the rating, if a food establishment is open, it has met acceptable health department requirements at the time of the last inspection. \n\nThere are two types of violations:"
    
    static let criticalViolationsText = "Critical violations may potentially pose an immediate risk to public health. You should make any decisions to use the establishment from your own personal judgement."
    
    static let noncriticalViolationsText = "Noncritical violations may overtime lead to problems within an establishment. Noncritical violations generally aren’t considered an immediate health concern to the public, but every consumer is encouraged to use their own judgement before using an establishment."
    
    static let pointValues = "Violation points may be a value of 1, 3, or 6. These points used to calculate an establishment’s score are listed below:"
    
    static let pointExplanation = "Violation points are accumulated during a routine inspection. The lower the score, the better the inspection results."
}
