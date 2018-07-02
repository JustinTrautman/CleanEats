//
//  PlaceMarker.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/1/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation
import GoogleMaps

class PlaceMarker: GMSMarker {
    
    let place: RestaurantSearch
    
    init(place: RestaurantSearch) {
        self.place = place
        super.init()
        
        position = place.coordinate
        icon = UIImage(named: "RestaurantMarker")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
    }
}
