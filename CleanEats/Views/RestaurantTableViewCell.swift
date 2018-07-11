//
//  RestaurantTableViewCell.swift
//  CleanEats
//
//  Created by Justin Trautman on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import SwiftyJSON

class RestaurantTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantRatingImageView: UIImageView!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    @IBOutlet weak var restaurantPriceLabel: UILabel!
    @IBOutlet weak var restaurantScoreLabel: UILabel!
    
    var restaurants: Businesses? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        
        guard let restaurant = restaurants else { return }
        guard let restaurantDistance = restaurant.restaurantDistance,
             let categories = restaurant.categories else { return }
        
//        restaurantImageView.image = restaurant.restaurantImage
        restaurantNameLabel.text = restaurant.restaurantName
       // restaurantRatingImageView.image = restaurant.restaurantRating
        restaurantDistanceLabel.text = "\((restaurantDistance * 0.000621).rounded()) Miles"
        restaurantDescriptionLabel.text = "\(categories)"
        restaurantPriceLabel.text = restaurant.restaurantPrice
        // restaurantScoreLabel.text = restaurant.restaurantRisk
    }
}
