//
//  ReviewsTableViewCell.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import Kingfisher

// ✅ TODO: Why is yelp only returning part of a review?
// ANSWER: The Yelp API does not return full review text. Three review excerpts of 160 characters are provided by default.
// Solution: I will move to Google Place API so we get more reviews and the full review text... 

class ReviewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var reviews: Reviews? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var reviewerNameLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewTextLabel: UILabel!
    
    func updateViews() {
        guard let reviews = reviews else {
            return
        }
        
        let name = reviews.userData.reviewerName ?? "Unknown Name"
        let datePosted = reviews.reviewTimestamp.formattedDate
        let rating = Double(reviews.rating ?? 0).roundToClosestHalf()
        let reviewText = reviews.reviewText
        
        DispatchQueue.main.async {
            self.reviewerNameLabel.text = name
            self.reviewDateLabel.text = "Posted: \(datePosted)"
            self.ratingImageView.image = StarRatingHelper.returnStarFrom(rating: rating)
            self.reviewTextLabel.text = reviewText
        }
        
        if let profileImageString = reviews.userData.reviewerImageURL {
            let imageUrl = URL(string: profileImageString)
            let transition = ImageTransition.fade(0.2)
            
            DispatchQueue.main.async {
                self.profileImageView.kf.indicatorType = .activity
                self.profileImageView.kf.setImage(with: imageUrl, options: [.transition(transition)])
                self.profileImageView.roundImage()
            }
        }
    }
}
