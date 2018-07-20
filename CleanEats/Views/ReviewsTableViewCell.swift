//
//  ReviewsTableViewCell.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var reviewerProfileImage: UIImageView!
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewTextLabel: UILabel!
    
    
    // MARK: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Properties
    
    var reviews: Reviews? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard let reviews = reviews,
              let profileImageString = reviews.userData.reviewerImageURL else { return }
        
        self.reviewerName.text = reviews.userData.reviewerName
        self.reviewDateLabel.text = reviews.reviewTimestamp
        self.reviewTextLabel.text = reviews.reviewText
        
        
        DispatchQueue.main.async {
            RestaurantReviewController.getReviewerImage(imageStringURL: profileImageString) { (image) in
                if let image = image {
                    let fetchedImage = image
                    self.reviewerProfileImage.image = fetchedImage
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }

        }
    }
}

extension Notification.Name {
    static let sendBusiness = Notification.Name("sendBusiness")
}
