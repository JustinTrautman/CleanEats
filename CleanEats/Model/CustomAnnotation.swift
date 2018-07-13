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
    var restaurantName: String!
    var restaurantImageUrlString: String!
    var restaurantID: String?
    var restaurantRating: Double!
    var restaurantPrice: String?
    var restaurantPhone: String?
    var restaurantDistance: Double?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }

}

