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

struct Businesses : Codable {
    
    let restaurantID: String?
    let restaurantName: String?
    let restaurantImage: String
    let categories: [Categories]?
    let restaurantRating: Double?
    let restaurantPrice: String?
    let restaurantPhone: String?
    let restaurantDistance: Double?
    var coordinate: CLLocationCoordinate2D? = CLLocationCoordinate2D()
    
    struct Categories : Codable {
        
        let alias: String?
        let title: String?
    }
    
    enum CodingKeys: String, CodingKey {
        
        case restaurantID = "id"
        case restaurantName = "name"
        case restaurantImage = "image_url"
        case categories
        case restaurantRating = "rating"
        case restaurantPrice = "price"
        case restaurantPhone = "display_phone"
        case restaurantDistance = "distance"
    }
}
