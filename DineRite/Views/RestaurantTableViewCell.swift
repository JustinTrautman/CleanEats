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

        let distanceInMiles = restaurantDistance * 0.000621

        restaurantNameLabel.text = restaurant.restaurantName
       // restaurantRatingImageView.image = restaurant.restaurantRating
        restaurantDistanceLabel.text = "\((distanceInMiles * 100).rounded() / 100) miles away"
        restaurantPriceLabel.text = restaurant.restaurantPrice
        restaurantDescriptionLabel.text = "\(categories)"
        // restaurantScoreLabel.text = restaurant.restaurantRisk
        
        RestaurantInfoController.getRestaurantImage(imageStringURL: restaurant.restaurantImage) { (image) in
            guard let fetchedImage = image else { return }
            DispatchQueue.main.async {
                self.restaurantImageView.image = fetchedImage
            }
        }
    }
}
