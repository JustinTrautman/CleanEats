//
//  RestaurantController.swift
//  CleanEats
//
//  Created by Huzaifa Gadiwala on 9/7/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation

class RestaurantController {
    
    // Source of truth
    var restaurants: [Restaurant] {
        let restuarunts = [
            Restaurant(restaurantImage: #imageLiteral(resourceName: "Burger"), restaurantTitle: "Cubbys", restaurantRating: #imageLiteral(resourceName: "5Stars"), ratingCount: 3, isFavorite: true, restaurantDistance: "1.8 Miles Away", restaurantDescription: "America(New), Sandwiches, Salad", restaurantPrice: "$$", restaurantRisk: "18"),
            Restaurant(restaurantImage: #imageLiteral(resourceName: "Fuddruckers"), restaurantTitle: "Fuddruckers", restaurantRating: #imageLiteral(resourceName: "5Stars"), ratingCount: 4, isFavorite: true, restaurantDistance: "3 Miles Away", restaurantDescription: "Make your own sandwhiches", restaurantPrice: "$", restaurantRisk: "20"),
            Restaurant(restaurantImage: #imageLiteral(resourceName: "Apollo Burger"), restaurantTitle: "Apollo Burger", restaurantRating: #imageLiteral(resourceName: "5Stars"), ratingCount: 5, isFavorite: true, restaurantDistance: "1.5 Miles Away", restaurantDescription: "Burgers, fries", restaurantPrice: "$", restaurantRisk: "15")
        ]
        
        return restuarunts
    }
    
    // add mock data to this array as a computed property
    
    
}


// TVC
//numberOfRowsInsection
// return RestaurantController.shared.restaurants.map{$0.isFavorite}

