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
        guard let reviews = reviews else { return }
        self.reviewDateLabel.text = reviews.reviewTimestamp
        self.reviewTextLabel.text = reviews.reviewText
    }
    
}

extension Notification.Name {
    static let sendBusiness = Notification.Name("sendBusiness")
}
