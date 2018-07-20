//
//  RestaurantDetail.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/3/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

/*
 
 TODO: Add explanation of file
 
 */

struct RestaurantDetails : Codable {
    
    let reviewCount: Int
    let photos: [Photos]
    let hours: [Hours]
    //let location: [Location]
    
    enum CodingKeys : String, CodingKey {
        
        case reviewCount = "review_count"
        case photos, hours //, location
    }
}

struct Photos : Codable{
    
    let photoURL: String?
}

struct Hours : Codable {
    
    let open: [Open]
}

//struct Location : Codable {
//
//    let completeAddress: String?
//
//    enum CodingKeys : String, CodingKey {
//
//        case completeAddress = "display_address"
//    }
//}

struct Open : Codable {
    
    let closingTime: String?
    let dayOfTheWeek: Int?
    let openingTime: String?
    
    enum CodingKeys : String, CodingKey {
        case closingTime = "end"
        case dayOfTheWeek = "day"
        case openingTime = "start"
    }
}

enum CodingKeys : String, CodingKey {
    
    
    case closingTime = "end"
    case dayOfTheWeek = "day"
    case openingTime = "start"
}

