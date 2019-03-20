//
//  CalloutView.swift
//
//
//  Created by Huzaifa Gadiwala on 12/7/18.
//
import UIKit

protocol CalloutViewDelegate: class {
    func calloutViewTapped(restaurant: Businesses, sender: CalloutView)
}

@IBDesignable class CalloutView: UIView {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var restaurantDistance: UILabel!
    @IBOutlet weak var buttonTapped: UIButton!
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    weak var delegate: CalloutViewDelegate?
    var restaurant: Businesses? {
        didSet {
            guard let restaurant = restaurant else {
                return
            }
            
            let restaurantDistance = restaurant.restaurantDistance ?? 0
            let distanceInMiles = restaurantDistance.inMiles
            let rating = restaurant.restaurantRating ?? 0
            
            DispatchQueue.main.async {
                self.ratingImageView.image = StarRatingHelper.returnStarFrom(rating: rating)
                self.restaurantImage.layer.cornerRadius = 4
                self.restaurantImage.clipsToBounds = true
                self.restaurantDistance.text = "\(distanceInMiles) miles away"
                self.restaurantName.text = restaurant.restaurantName ?? ""
            }
        }
    }
    
    @IBAction func calloutButtonTapped(_ sender: Any) {
        guard let restaurant = restaurant else {
            return
        }
        delegate?.calloutViewTapped(restaurant: restaurant, sender: self)
    }
}
