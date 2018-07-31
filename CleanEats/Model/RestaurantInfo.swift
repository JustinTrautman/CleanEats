//
//  RestaurantInfo.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//
/*
 
 This uses the Yelp API for business search
 This model is the data for the tableViewCell on the SearchPage
 
 */
import Foundation
import MapKit
struct TopLevelData : Codable {
    
    let businesses: [Businesses]
}
class Businesses : NSObject, Codable {

    let restaurantID: String?
    var restaurantName: String?
    let restaurantImage: String
    let categories: [Categories]?
    let restaurantRating: Double?
    let restaurantReviewCount: Int?
    let restaurantPrice: String?
    let restaurantPhone: String?
    let restaurantDistance: Double?
    var coordinate: Coordinate?
    let location: Location?
    var imageForRating: UIImage? {
        guard let rating = restaurantRating, let ratingEnum = Rating(rawValue: Int(rating)) else {
            return UIImage()
        }
        switch ratingEnum {
        case .oneStar:
            return UIImage(named: "oneStar")
        case .twoStar:
            return UIImage(named: "twoStars")
        case .threeStar:
            return UIImage(named: "threeStars")
        case .fourStar:
            return UIImage(named: "fourStars")
        case .fiveStar:
            return UIImage(named: "fiveStars")
        }
    }
    

    init(restaurantID: String?, restaurantName: String?, restaurantImage: String, categories: [Categories]?, restaurantRating: Double?, restaurantReviewCount: Int?, restaurantPrice: String?, restaurantPhone: String?, restaurantDistance: Double?, location: Location?) {
        self.restaurantID = restaurantID
        self.restaurantName = restaurantName
        self.restaurantImage = restaurantImage
        self.categories = categories
        self.restaurantRating = restaurantRating
        self.restaurantReviewCount = restaurantReviewCount
        self.restaurantPrice = restaurantPrice
        self.restaurantPhone = restaurantPhone
        self.restaurantDistance = restaurantDistance
        self.location = location

    }
    
    struct Coordinate: Codable {
        let latitude: Double
        let longitude: Double
        
    }
    
    struct Categories : Codable {
        
        let alias: String?
        let title: String?
    }
    struct Location: Codable {
        let address1: String?
        let city: String?
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case restaurantID = "id"
        case restaurantName = "name"
        case restaurantImage = "image_url"
        case categories
        case restaurantRating = "rating"
        case restaurantReviewCount = "review_count"
        case restaurantPrice = "price"
        case restaurantPhone = "display_phone"
        case restaurantDistance = "distance"
        case coordinate = "coordinates"
        case location = "location"
        
    }
    
    
}

enum Rating: Int{
    case oneStar = 1
    case twoStar = 2
    case threeStar = 3
    case fourStar = 4
    case fiveStar = 5
}
