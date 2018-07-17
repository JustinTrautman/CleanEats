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
    
    var favorites: [Favorite] = []
    
    init() {
       // self.favorites = load()
    }
    
    func fileUrls() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let favoritesLocation = "dinerite.json"
        let url = documentDirectory.appendingPathComponent(favoritesLocation)
        return url
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
    
        do {
            let data = try jsonEncoder.encode(favorites)
            try data.write(to: fileUrls())
        } catch let error {
            print("File url error saving to path \(#function) \(error) \(error.localizedDescription)")
        }
    }
    
    func load() -> [Favorite] {
        
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileUrls())
            let favorites = try jsonDecoder.decode([Favorite].self, from: data)
            return favorites
            
        } catch let error {
            print("Error loading playlists from fileURL: \(#function) \(error) \(error.localizedDescription)")
            return []
        }
    }
}
