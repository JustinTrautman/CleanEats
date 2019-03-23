//
//  ReviewDetailViewController.swift
//  DineRite
//
//  Created by Justin Trautman on 3/18/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit
import Kingfisher

class ReviewDetailViewController: UIViewController {
    // MARK: Properties
    var review: Reviews? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var ratingImageView: UIImageView!
    @IBOutlet weak private var datePostedLabel: UILabel!
    @IBOutlet weak private var reviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateViews() {
        guard let review = review else {
            return
        }
        
        let name = review.userData.reviewerName ?? "Unknown Name"
        let rating = Double(review.rating ?? 0).roundToClosestHalf()
        let datePosted = review.reviewTimestamp.formattedDate
        let reviewText = review.reviewText
        
        DispatchQueue.main.async {
            self.nameLabel.text = name
            self.ratingImageView.image = StarRatingHelper.returnStarFrom(rating: rating)
            self.datePostedLabel.text = datePosted
            self.reviewTextView.text = reviewText
        }
        
        if let profileImageUrl = review.userData.reviewerImageURL {
            let imageUrl = URL(string: profileImageUrl)
            let transition = ImageTransition.fade(0.2)
            
            DispatchQueue.main.async {
                self.profileImageView.kf.indicatorType = .activity
                self.profileImageView.kf.setImage(with: imageUrl, options: [.transition(transition)])
                self.profileImageView.roundImage()
            }
        }
    }
}
