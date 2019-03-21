//
//  FavoriteController.swift
//  DineRite
//
//  Created by Justin Trautman on 3/19/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import Foundation
import CoreData

class FavoriteController {
    
    static func add(image: Data, name: String, phone: String, address: String, rating: Double, healthScore: Int64) {
        Favorite(image: image, name: name, phone: phone, address: address, rating: rating, healthScore: healthScore)
        saveToPersistentStore()
    }
    
    static func delete(favorite: Favorite) {
            CoreDataStack.context.delete(favorite)
            saveToPersistentStore()
    }
    
    private static func saveToPersistentStore() {
        let managedObjectContext = CoreDataStack.context
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving data to persistent store. \(error.localizedDescription)")
        }
    }
}
