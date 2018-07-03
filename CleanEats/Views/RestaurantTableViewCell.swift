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
    @IBOutlet weak var restaurantTitleLabel: UILabel!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var placeInfo: JSON! {
        didSet {
            updateTableView()
        }
    }
    
    func updateTableView() {
        restaurantTitleLabel.text = placeInfo["name"].stringValue
    }
    
}
