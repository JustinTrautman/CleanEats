//
//  FavoriteTableViewCell.swift
//  CleanEats
//
//  Created by Huzaifa Gadiwala on 5/7/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    // MARK: Properties
    let rating: Double? = 0.0
    var imageForRating: UIImage?
    var restaurant: Businesses?
    
    var favorite: Favorite? {
        didSet{
            updateViews()
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantRatingImageView: UIImageView!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantScoreLabel: UILabel!
    @IBOutlet weak var restaurantPhoneNumber: UILabel!
    
    func updateViews() {
        var image = UIImage()
        let name = favorite?.name ?? "Unknown Name"
        let phone = favorite?.phone == "" ? "No phone number" : favorite?.phone
        let rating = favorite?.rating ?? 0
        let healthScore = favorite?.healthScore ?? 0
        let address = favorite?.address ?? "No address available"
        
        if let imageData = favorite?.image {
            image = UIImage(data: imageData) ?? #imageLiteral(resourceName: "noImage")
        }
        
        DispatchQueue.main.async {
            self.restaurantImageView.image = image
            self.restaurantNameLabel.text = name
            self.restaurantRatingImageView.image = StarRatingHelper.returnStarFrom(rating: rating)
            self.restaurantScoreLabel.text = String(describing: healthScore)
            self.restaurantPhoneNumber.text = phone
            self.restaurantAddressLabel.text = address
        }
    }
}
