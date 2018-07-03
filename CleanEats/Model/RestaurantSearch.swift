//
//  Restaurant Search.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/1/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

//  Model for place results returned from Google

import UIKit
import CoreLocation
import SwiftyJSON

struct RestaurantSearch {

    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let placeType: String
    let placeID: String
    var photoReference: String?
    var photo: UIImage?
    
    init(dictionary: [String: Any], acceptedTypes: [String])
    {
        let json = JSON(dictionary)
        name = json["name"].stringValue
        address = json["vicinity"].stringValue
        placeID = json["place_id"].stringValue
        
        let lat = json["geometry"]["location"]["lat"].doubleValue as CLLocationDegrees
        let lng = json["geometry"]["location"]["lng"].doubleValue as CLLocationDegrees
        coordinate = CLLocationCoordinate2DMake(lat, lng)
        
        photoReference = json["photos"][0]["photo_reference"].string
        
        var foundType = "restaurant"
        let possibleTypes = acceptedTypes.count > 0 ? acceptedTypes : ["meal_takeaway", "bar", "meal_delivery", "supermarket", "restaurant"]
        
        if let types = json["types"].arrayObject as? [String] {
            for type in types {
                if possibleTypes.contains(type) {
                    foundType = type
                    break
                }
            }
        }
        placeType = foundType
    }
}
