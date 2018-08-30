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
    
    var restaurantDetails: Businesses?
    
    var restaurant: Restaurant? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let restaurant = restaurant,
        let phone = restaurantDetails?.restaurantPhone,
        let desriptionCategories = restaurantDetails?.categories else { return }
        
        let description1 = desriptionCategories[0].title
        let description2 = desriptionCategories[1].title
        let description3 = desriptionCategories[2].title
        
//        restaurantImageView.image = restaurant.restaurantImage
        restaurantImageView.image = restaurant.restaurantImage
        restaurantNameLabel.text = restaurant.restaurantTitle
        restaurantRatingImageView.image = #imageLiteral(resourceName: "fiveStars")
        restaurantDistanceLabel.text = restaurant.restaurantDistance
        restaurantDescriptionLabel.text = "\(description1); \(description2); \(description3)"
        restaurantScoreLabel.text = "5"
//        restaurantScoreLabel.text = restaurant.restaurantRisk
        restaurantPhoneNumber.text = phone
    }
}
