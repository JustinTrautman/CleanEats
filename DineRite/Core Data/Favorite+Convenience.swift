//
//  Favorite+Convenience.swift
//  DineRite
//
//  Created by Justin Trautman on 3/19/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation
import CoreData

extension Favorite {
    @discardableResult convenience init(image: Data?, name: String, phone: String, address: String, rating: Double, healthScore: Int64, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.image = image
        self.name = name
        self.phone = phone
        self.address = address
        self.rating = rating
        self.healthScore = healthScore
    }
}
