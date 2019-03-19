//
//  DoubleExtension.swift
//  DineRite
//
//  Created by Justin Trautman on 3/18/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation

extension Double {
    func roundToClosestHalf() -> Double {
        return Double(Int(self * 2)) / 2
    }
    
    /// Returns a double with a specified amount of decimal places.
    func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    /// Turns a meter distance into a mile distance rounded to 2 decimal places.
    var inMiles: Double {
        let roundedMileDistance = (self / 1609.344).roundToPlaces(places: 2)
        return roundedMileDistance
    }
}
