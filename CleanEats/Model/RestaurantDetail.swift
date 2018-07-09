//
//  RestaurantDetail.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/3/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation

struct TopLevelData: Codable {
    
    let results: [RestaurantDetail]
    
    struct RestaurantDetail: Codable {
        
        let name: String
        let priceLevel: Double
        let rating: Double
        let phoneNumber: String
        let placeID: String
        
        enum codingKeys: String, CodingKey {
            case name
            case priceLevel = "price_level"
            case rating
            case phoneNumber = "formatted_phone_number"
            case placeID = "place_id"
        }
    }
}

