//
//  FavoriteTableViewCell.swift
//  CleanEats
//
//  Created by Huzaifa Gadiwala on 5/7/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let shared = FavoriteTableViewCell()
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
    }
}
