//
//  FavoriteTableViewCell.swift
//  CleanEats
//
//  Created by Huzaifa Gadiwala on 5/7/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    let rating: Double? = 0.0
    var imageForRating: UIImage?
    
    var favorites: Favorite? {
        didSet{
            updateViews()
        }
    }
    
    var restaurant: Businesses?
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantRatingImageView: UIImageView!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    @IBOutlet weak var restaurantScoreLabel: UILabel!
    @IBOutlet weak var restaurantPhoneNumber: UILabel!
    
    //    override func layoutSubviews() {
    //        updateViews()
    //    }
    
    func updateViews() {
        // Load image from UserDefaults
        let imageData = UserDefaults.standard.value(forKey: "key") as! Data
        let imageFromData = UIImage(data: imageData)!
        
        restaurantImageView.image = imageFromData
        
        if let name = favorites?.restaurantName {
            restaurantNameLabel.text = name
        }
        
        if let phone = favorites?.restaurantPhone {
            restaurantPhoneNumber.text = phone
        }
        
        if let description = favorites?.restaurantDescription {
            restaurantDescriptionLabel.text = description
        }
        
        if let ratingStringAmount = favorites?.restaurantRating {
            guard let ratingDouble = Double(ratingStringAmount) else { return }
            
            guard let ratingEnum = RatingEnum(rawValue: Double(ratingDouble)) else { return }
            
            if let rating = favorites?.restaurantRating {
                
                switch ratingEnum {
                case .oneStar:
                    imageForRating = UIImage(named: "1Star")
                case .onePointFiveStar:
                    imageForRating = UIImage(named: "1.5Star")
                case .twoStar:
                    imageForRating = UIImage(named: "2Stars")
                case .twoPointFiveStar:
                    imageForRating = UIImage(named: "2.5Stars")
                case .threeStar:
                    imageForRating = UIImage(named: "3Stars")
                case .threePointFiveStar:
                    imageForRating = UIImage(named: "3.5Stars")
                case .fourStar:
                    imageForRating = UIImage(named: "4Stars")
                case .fourPointFiveStar:
                    imageForRating = UIImage(named: "4.5Stars")
                case .fiveStar:
                    imageForRating = UIImage(named: "5Stars")
                default:
                    imageForRating = UIImage(named: "0Stars")
                }
                restaurantRatingImageView.image = imageForRating
            }
        }
    }
}
