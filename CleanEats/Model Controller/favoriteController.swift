//
//  favoriteController.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/12/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation
import CoreData

class FavoriteController {
    
    static let shared = FavoriteController()
    
    // MARK: - Properties
     var favorites: [Favorite] = []
    
    // MARK: - CRUD
    static func createFavoriteWith(restaurantTitle: String, restaurantPrice: String, inspectionScore: String, restaurantImage: String, restaurantDescription: String) {
        let _ = Favorite(restaurantTitle: restaurantTitle, restaurantPrice: restaurantPrice, restaurantImage: restaurantImage, restaurantDescription: restaurantDescription, inspectionScore: inspectionScore)
         saveToFavorites()
    }
    
    static func delete(favorite: Favorite) {
        favorite.managedObjectContext?.delete(favorite)
         saveToFavorites()
    }
    
    static func saveToFavorites() {
        if CoreDataStack.context.hasChanges {
            try? CoreDataStack.context.save()
        }
    }
}
