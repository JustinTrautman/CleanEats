//
//  RestaurantInfo.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

/*
 
 This model pulls from the Yelp API for business search
 and retrieves data for the Restaurant Profile screen.
 
 */

import Foundation
import MapKit

struct TopLevelData : Codable {
    let businesses: [Businesses]
}

class Businesses: Codable {
    
    let restaurantID: String?
    let alias: String?
    var restaurantName: String?
    let restaurantImage: String
    let isClosed: Bool
    let yelpUrl: String?
    let categories: [Categories]?
    let restaurantRating: Double?
    let restaurantReviewCount: Int?
    let restaurantPrice: String?
    let restaurantPhone: String?
    let restaurantDistance: Double?
    var coordinate: Coordinate?
    let location: Location?
    
    var imageForRating: UIImage? {
        guard let rating = restaurantRating, let ratingEnum = RatingEnum(rawValue: Double(rating)) else {
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
    
    public var title: String? {
        get { return restaurantName }
    }
    
    public var newCoordinate: CLLocationCoordinate2D {
        guard let longitude = coordinate?.longitude,
            let lat = coordinate?.latitude
            else { return  CLLocationCoordinate2D()}
        return CLLocationCoordinate2D(latitude: lat, longitude: longitude)
    }
    
    init(restaurantID: String?, alias: String?, restaurantName: String?, restaurantImage: String, isClosed: Bool, yelpUrl: String?, categories: [Categories]?, restaurantRating: Double?, restaurantReviewCount: Int?, restaurantPrice: String?, restaurantPhone: String?, restaurantDistance: Double?, location: Location?) {
        self.restaurantID = restaurantID
        self.alias = alias
        self.restaurantName = restaurantName
        self.restaurantImage = restaurantImage
        self.isClosed = isClosed
        self.yelpUrl = yelpUrl
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
    
    struct Categories: Codable {
        let alias: String?
        let title: String?
    }
    
    struct Location: Codable {
        let displayAddress: [String]
        
        enum CodingKeys: String, CodingKey {
            
            case displayAddress = "display_address"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case restaurantID = "id"
        case alias
        case restaurantName = "name"
        case restaurantImage = "image_url"
        case isClosed = "is_closed"
        case yelpUrl = "url"
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
