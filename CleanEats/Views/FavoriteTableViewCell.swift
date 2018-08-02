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
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    @IBOutlet weak var restaurantScoreLabel: UILabel!
    @IBOutlet weak var restaurantPhoneNumber: UILabel!
    
    var restaurant: Restaurant? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let restaurant = restaurant else { return }
        
//        restaurantImageView.image = restaurant.restaurantImage
        restaurantImageView.image = UIImage(named: "Spitz1")
        restaurantNameLabel.text = "Spitz SLC"
        restaurantRatingImageView.image = restaurant.restaurantRating
        restaurantDistanceLabel.text = restaurant.restaurantDistance
        restaurantDescriptionLabel.text = "Mediterranean Restaurant"
        restaurantScoreLabel.text = restaurant.restaurantRisk
        restaurantPhoneNumber.text = "(801) 364-0286"
    }


}
