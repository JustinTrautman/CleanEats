//
//  RestaurantDetail.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/3/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

/*
 
 TODO: This model pulls from the Yelp business detail API to get detailed information of each restaurant.
 
 */

import UIKit

struct RestaurantDetails : Codable {
    let name: String
    let phone: String
    let reviewCount: Int
    let rating: Double?
    let location: Location
    let photos: [String]?
    let hours: [Hour]?
    var imageForRating: UIImage? {
        guard let rating = rating, let ratingEnum = RatingEnum(rawValue: Double(Double(rating))) else {
            return UIImage()
        }
        switch ratingEnum {
        case .oneStar:
            return UIImage(named: "1Star")
        case .onePointFiveStar:
            return UIImage(named: "1.5Stars")
        case .twoStar:
            return UIImage(named: "2Stars")
        case .twoPointFiveStar:
            return UIImage(named: "2.5Stars")
        case .threeStar:
            return UIImage(named: "3Stars")
        case .threePointFiveStar:
            return UIImage(named: "3.5Stars")
        case .fourStar:
            return UIImage(named: "4Stars")
        case .fourPointFiveStar:
            return UIImage(named: "4.5Stars")
        case .fiveStar:
            return UIImage(named: "5Stars")
        default:
            return UIImage(named: "0Stars")
        }
    }
    
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
