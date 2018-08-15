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
    @IBOutlet weak var restaurantPrice: UILabel!
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
            self.restaurantName.text = restaurant.restaurantName ?? ""

            if let restaurantDistance = restaurant.restaurantDistance {
                let distanceInMiles = round((restaurantDistance/16.0934))/100
                self.restaurantDistance.text = "\(distanceInMiles) miles away"
            }

            self.ratingImageView.image = restaurant.imageForRating
            self.restaurantImage.layer.cornerRadius = 4
            self.restaurantImage.clipsToBounds = true
            
            
            // set the image view(s) for the detail photos property
            /*
             self.collectionView.count = restaurant.detailPhotos
             let photos = restaurant.detailPhotos
             for photo in photos {
             // self.whateverImageView.image = photo
             
             }
             */
            
        
        }
    }
    
    @IBAction func calloutButtonTapped(_ sender: Any) {
        guard let restaurant = restaurant else {
            return
        }
        delegate?.calloutViewTapped(restaurant: restaurant, sender: self)
    }
    
}
