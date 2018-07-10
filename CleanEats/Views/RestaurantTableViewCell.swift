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
        
       // restaurantImageView.image = restaurant.restaurantImage
        restaurantNameLabel.text = restaurant.restaurantName
       // restaurantRatingImageView.image = restaurant.restaurantRating
        restaurantDistanceLabel.text = "\(restaurant.restaurantDistance)"
        restaurantDescriptionLabel.text = "\(restaurant.categories)"
        restaurantPriceLabel.text = restaurant.restaurantPrice
        // restaurantScoreLabel.text = restaurant.restaurantRisk
        
        RestaurantInfoController.fetchRestaurantInfo(with: "Mos", andLocation: "Newport") { (business) in
            let fetchedRestaurantData = restaurant
            self.restaurants = fetchedRestaurantData
        }
    }
}
