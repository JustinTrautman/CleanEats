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
        let Cubbys = Restaurant(restaurantImage: #imageLiteral(resourceName: "Burger"), restaurantTitle: "Cubbys", restaurantRating: #imageLiteral(resourceName: "5Stars"), ratingCount: 3, restaurantDistance: "1.8 Miles Away", restaurantDescription: "America(New), Sandwiches, Salad", restaurantPrice: "$$", restaurantRisk: "18", ),
        
        let fuddruckers = Restaurant(restaurantImage: #imageLiteral(resourceName: "Fuddruckers"), restaurantTitle: "Fuddruckers", restaurantRating: #imageLiteral(resourceName: "5Stars"), ratingCount: 4, restaurantDistance: "3 Miles Away", restaurantDescription: "Make your own sandwhiches", restaurantPrice: "$", restaurantRisk: "20"),
        
        let apolloBurger = Restaurant(restaurantImage: #imageLiteral(resourceName: "Apollo Burger"), restaurantTitle: "Apollo Burger", restaurantRating: #imageLiteral(resourceName: "5Stars"), ratingCount: 5, restaurantDistance: "1.5 Miles Away", restaurantDescription: "Burgers, fries", restaurantPrice: "$", restaurantRisk: "15"),

        ]
        
        return restuarunts
    }
    
    // add mock data to this array as a computed property
    
    
}


// TVC
//numberOfRowsInsection
// return RestaurantController.shared.restaurants.map{$0.isFavorite}

