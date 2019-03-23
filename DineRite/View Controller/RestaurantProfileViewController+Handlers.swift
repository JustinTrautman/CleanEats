//
//  RestaurantProfileViewController+Handlers.swift
//  DineRite
//
//  Created by Justin Trautman on 3/17/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

extension RestaurantProfileViewController {
    @objc func handleSegmentSelectionChange(_ sender: UISegmentedControl) {
        updateContainerView()
    }
    
    @objc func handleFavoriteStarTap() {
        guard let restaurant = restaurantDetails else {
            return
        }
        
        var image = Data()
        if let restaurantImage = restaurantPhotos.first {
            image = restaurantImage.pngData()!
        }
        
        let name = restaurant.name
        let phone = restaurant.phone
        let rating = restaurant.rating ?? 0
        let healthScore = Int64(totalInspectionPoints)
        var address = ""
        
        if let completeAddress = restaurant.location.completeAddress.first.flatMap ({ $0 }) {
            address = completeAddress
        }
        
        Favorite(image: image, name: name, phone: phone, address: address, rating: rating, healthScore: healthScore)
        
        DispatchQueue.main.async {
            if self.favoriteStarButton.isSelected {
                self.favoriteStarButton.setImage(#imageLiteral(resourceName: "Favicon1"), for: .normal)
                self.favoriteStarButton.isSelected = false
                
                self.removeFavorite(withName: name)
            } else {
                self.favoriteStarButton.setImage(#imageLiteral(resourceName: "favoriteStarFilled"), for: .normal)
                self.favoriteStarButton.isSelected = true
            }
        }
    }
}
