//
//  Favorite+Convenience.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/12/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation
import CoreData

extension Favorite {
    convenience init(restaurantTitle: String,
                     restaurantPrice: String,
                     restaurantImage: String,
                     restaurantDescription:String,
                     inspectionScore: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.restaurantTitle = restaurantTitle
        self.restaurantPrice = restaurantPrice
        self.restaurantImage = restaurantImage
        self.inspectionScore = inspectionScore
    }
}
