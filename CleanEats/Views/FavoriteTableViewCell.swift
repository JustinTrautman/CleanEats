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
    @IBOutlet weak var restaurantPriceLabel: UILabel!
    @IBOutlet weak var restaurantRatingImageView: UIImageView!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    @IBOutlet weak var restaurantScoreLabel: UILabel!
    
    
    var restaurant: Restaurant? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let restaurant = restaurant else { return }
        
        restaurantImageView.image = restaurant.restaurantImage
        restaurantNameLabel.text = restaurant.restaurantTitle
        restaurantRatingImageView.image = restaurant.restaurantRating
        restaurantDistanceLabel.text = restaurant.restaurantDistance
        restaurantDescriptionLabel.text = restaurant.restaurantDescription
        restaurantPriceLabel.text = restaurant.restaurantPrice
        restaurantScoreLabel.text = restaurant.restaurantRisk
    }

}
