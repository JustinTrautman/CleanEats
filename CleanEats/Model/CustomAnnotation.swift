//
//  CustomAnnotation.swift
//  CleanEats
//
//  Created by Huzaifa Gadiwala on 11/7/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var restaurantName: String? {
        return restaurant.restaurantName
    }
    var restaurantImageUrlString: String {
        return restaurant.restaurantImage
    }
    var restaurantID: String? {
        return restaurant.restaurantID
    }
    var restaurantRating: Double? {
        return restaurant.restaurantRating
    }
    var restaurantPrice: String? {
        return restaurant.restaurantPrice
    }
    var restaurantPhone: String? {
        return restaurant.restaurantPhone
    }
    var restaurantDistance: Double? {
        return restaurant.restaurantDistance
    }
    var restaurant: Businesses
    
    init(coordinate: CLLocationCoordinate2D, restaurant: Businesses) {
        self.coordinate = coordinate
        self.restaurant = restaurant
    }

}

