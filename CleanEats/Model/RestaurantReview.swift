//
//  RestaurantReviews.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/10/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

/*
 
 This model uses the Yelp Reviews API to get reviews for a selected restaurant.
 
 */

import Foundation

struct TopReviewData : Codable {
    let reviews: [Reviews]
}

struct Reviews : Codable {
    let restaurantID: String
    let reviewText: String
    let reviewTimestamp: String
    let userData: [User]
    
    enum CodingKeys: String, CodingKey {
        case restaurantID = "id"
        case reviewText = "text"
        case reviewTimestamp = "time_created"
        case userData = "user"
    }
    
    struct User : Codable {
        let reviewerImageURL: String?
        let reviewerName: String?
        
        enum CodingKeys: String, CodingKey {
            case reviewerImageURL = "image_url"
            case reviewerName = "name"
        }
    }
}


