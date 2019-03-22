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
    
    static func add(favorite: Favorite) {
        let name = favorite.name ?? "Unknown Name"
        let phone = favorite.phone ?? "No phone number"
        let address = favorite.address ?? "No address"
        
        Favorite(image: favorite.image, name: name, phone: phone, address: address, rating: favorite.rating, healthScore: favorite.healthScore)
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
