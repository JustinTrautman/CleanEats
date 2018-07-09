//
//  RestaurantDetail.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/3/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

/*
 
 This is only restaurant mock data. To be deleted.
 
 */

struct RestaurantDetail  {
    
    let restaurantImage: UIImage
    let restaurantTitle: String
    let restaurantRating: UIImage
    let restaurantDistance: String
    let restaurantDescription: String
    let restaurantPrice: String
    let restaurantRisk: String
}

let Cubbys = RestaurantDetail(restaurantImage: #imageLiteral(resourceName: "Cubbys"), restaurantTitle: "Cubbys", restaurantRating: #imageLiteral(resourceName: "5Stars"), restaurantDistance: "1.8 Miles Away", restaurantDescription: "America(New), Sandwiches, Salad", restaurantPrice: "$$", restaurantRisk: "18")

let fuddruckers = RestaurantDetail(restaurantImage: #imageLiteral(resourceName: "Fuddruckers"), restaurantTitle: "Fuddruckers", restaurantRating: #imageLiteral(resourceName: "5Stars"), restaurantDistance: "3 Miles Away", restaurantDescription: "Make your own sandwhiches", restaurantPrice: "$", restaurantRisk: "20")

let apolloBurger = RestaurantDetail(restaurantImage: #imageLiteral(resourceName: "Apollo Burger"), restaurantTitle: "Apollo Burger", restaurantRating: #imageLiteral(resourceName: "5Stars"), restaurantDistance: "1.5 Miles Away", restaurantDescription: "Burgers, fries", restaurantPrice: "$", restaurantRisk: "15")

