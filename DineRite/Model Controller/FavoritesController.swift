//
//  FavoritesController.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/12/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class FavoriteController {
    
    static let shared = FavoriteController()
    
    var favoritesArray = [Favorite]()
    
    init() {
        self.favoritesArray = load()
    }
    
    func createFavoriteWith(image: String, name: String, price: String, rating: String, phone: String, description: String) {
        
        let favorites = Favorite(restaurantImage: image, restaurantName: name, restaurantPrice: price, restaurantRating: rating, restaurantPhone: phone, restaurantDescription: description)
        
        favoritesArray.append(favorites)
    }
    
    func fileUrls() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        
        let dineRiteLocation = "dinerite.json"
        let url = documentDirectory.appendingPathComponent(dineRiteLocation)
        return url
    }
    
    func saveToFavorites() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(favoritesArray)
            try data.write(to: fileUrls())
        } catch let error {
            print("File urls had an error saving to path \(#function) \(error) \(error.localizedDescription)")
        }
    }
    
    func load() -> [Favorite] {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileUrls())
            let favorites = try jsonDecoder.decode([Favorite].self, from: data)
            return favorites
        } catch let error {
            print("Error loading favorites from fileURL: \(#function) \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    func delete(favorite: Favorite) {
        guard let index = favoritesArray.index(of: favorite) else { return }
        favoritesArray.remove(at: index)
        print("Sucessfuly removed favorite")
        saveToFavorites()
    }
}
