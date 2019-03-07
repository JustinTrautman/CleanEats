//
//  DateExtension.swift
//  DineRite
//
//  Created by Justin Trautman on 3/5/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation

extension Date {
    /// Get the full current date in MMMM dd, yyyy
    func fullDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: date)
    }
}
