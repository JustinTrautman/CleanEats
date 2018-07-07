//
//  RestaurantDetail.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/3/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

struct RestaurantDetail {
    
    let restaurantImage: UIImage
    let restaurantTitle: String
    let estaurantRating: UIImage
    let restaurantDistance: String
    let restaurantDescription: String
    let restaurantPrice: String
    let restaurantRisk: String
    
    let mockData: [RestaurantDetail] = [
        RestaurantDetail(restaurantImage: #imageLiteral(resourceName: "Cubbys"), restaurantTitle: "Cubbys", estaurantRating: #imageLiteral(resourceName: "5Stars"), restaurantDistance: "1.8 Miles Away", restaurantDescription: "America(New), Sandwiches, Salad", restaurantPrice: "$$", restaurantRisk: "18")
    
    ]
}

