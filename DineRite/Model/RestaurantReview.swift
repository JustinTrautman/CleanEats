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

struct TopReviewData : Codable {
    let reviews: [Reviews]
}

class Reviews : NSObject, Codable {
    let restaurantID: String
    let reviewText: String
    let reviewTimestamp: String
    let userData: User
    let rating: Int?
    var imageForRating: UIImage? {
        guard let rating = rating, let ratingEnum = RatingEnum(rawValue: Double(rating)) else {
            return UIImage()
        }
        
        switch ratingEnum {
            case .oneStar:
            return UIImage(named: "1Star")
            case .onePointFiveStar:
            return UIImage(named: "1.5Star")
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
        }
    }
    
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
