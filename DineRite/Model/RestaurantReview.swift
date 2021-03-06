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
import UIKit

struct TopReviewData: Codable {
    let reviews: [Reviews]
}

class Reviews: NSObject, Codable {
    let restaurantID: String
    let reviewText: String
    let reviewTimestamp: String
    let userData: User
    let rating: Int?
    var imageForRating: UIImage?
    
    init(restaurantID: String, reviewText: String, reviewTimestamp: String, userData: User, rating: Int, imageForRating: UIImage?) {
        self.restaurantID = restaurantID
        self.reviewText = reviewText
        self.reviewTimestamp = reviewTimestamp
        self.userData = userData
        self.rating = rating
    }
    
    enum CodingKeys: String, CodingKey {
        case restaurantID = "id"
        case reviewText = "text"
        case reviewTimestamp = "time_created"
        case userData = "user"
        case rating
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
