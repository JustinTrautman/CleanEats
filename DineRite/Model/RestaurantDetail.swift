//
//  RestaurantDetail.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/3/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

struct RestaurantDetails : Codable {
    let name: String
    let phone: String
    let reviewCount: Int
    let rating: Double?
    let location: Location
    let photos: [String]?
    let hours: [Hour]?
    var imageForRating: UIImage? 
    
    enum CodingKeys : String, CodingKey {
        case name
        case phone = "display_phone"
        case reviewCount = "review_count"
        case rating
        case location
        case photos
        case hours
    }
}

struct Hour: Codable {
    let hourOpen: [Open]
    let hoursType: String
    let isOpenNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

struct Open: Codable {
    let isOvernight: Bool
    let start: String
    let end: String
    let day: Int
    
    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start
        case end
        case day
    }
}

struct Location : Codable {
    let completeAddress: [String?]
    
    enum CodingKeys : String, CodingKey {
        case completeAddress = "display_address"
    }
}
