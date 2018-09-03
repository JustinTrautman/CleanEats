//
//  FavoriteTableViewCell.swift
//  CleanEats
//
//  Created by Huzaifa Gadiwala on 5/7/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantRatingImageView: UIImageView!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    @IBOutlet weak var restaurantScoreLabel: UILabel!
    @IBOutlet weak var restaurantPhoneNumber: UILabel!
    
    var restaurantDetails: Businesses?
    var restaurant: Restaurant?
    
    override func layoutSubviews() {
        updateViews()
    }
    
    var favorites: Favorite? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        // Load image from UserDefaults
        let imageData = UserDefaults.standard.value(forKey: "key") as! Data
        let imageFromData = UIImage(data: imageData)!
        
        restaurantImageView.image = imageFromData
        
        if let restaurant = restaurant {
            restaurantNameLabel.text = restaurant.restaurantTitle
        }
        
        if let desriptionCategories = restaurantDetails?.categories {
            let description1 = desriptionCategories[0].title
            restaurantDescriptionLabel.text = "\(description1)"
        }
        
        if let criticalViolations = HealthViolationData.shared.criticalViolations {
            
            if let nonCriticalViolations = HealthViolationData.shared.nonCriticalViolations {
                restaurantScoreLabel.text = "\(criticalViolations.count + nonCriticalViolations.count)"
            }
        }
        
        if let restaurantDetails = restaurantDetails {
            restaurantPhoneNumber.text = restaurantDetails.restaurantPhone
        }
    }
}
