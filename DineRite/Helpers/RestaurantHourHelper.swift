//
//  RestaurantHourHelper.swift
//  DineRite
//
//  Created by Justin Trautman on 3/18/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation

struct RestaurantHoursHelper {
    /// Returns a restaurant's closing time for today's date. Accepts an Hour type returned from Yelp API.
    static func returnClosingTime(for restaurant: Hour) -> String {
        let today = Date().dayOfWeek()
        
        // TODO: Research - Yelp only returns hours for six days? Time to move away from yelp...
        
        guard restaurant.hourOpen.count >= 5 else {
            return "Hour information unknown" // If restaurant does not have hours for every day of the week, prevent it from fetching an idex that is out of range.
        }
        
        switch today {
        case "Monday":
            return restaurant.hourOpen[1].end.convertFromMilitaryTime()
        case "Tuesday":
            return restaurant.hourOpen[2].end.convertFromMilitaryTime()
        case "Wednesday":
            return restaurant.hourOpen[3].end.convertFromMilitaryTime()
        case "Thursday":
            return restaurant.hourOpen[4].end.convertFromMilitaryTime()
        case "Friday":
            return restaurant.hourOpen[5].end.convertFromMilitaryTime()
        default:
            return restaurant.hourOpen[0].end.convertFromMilitaryTime()
        }
    }
}
