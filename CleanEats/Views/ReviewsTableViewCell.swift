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

    
    func initializeReviewerProfileImage() {
        
        reviewerProfileImage.layer.cornerRadius = reviewerProfileImage.frame.size.width / 2
        reviewerProfileImage.clipsToBounds = false
        reviewerProfileImage.layer.masksToBounds = true
        reviewerProfileImage.layer.shadowRadius = 7.0
        reviewerProfileImage.layer.shadowColor = UIColor.black.cgColor
        reviewerProfileImage.layer.shadowOpacity = 0.4
        reviewerProfileImage.layer.shadowOffset = CGSize.zero
        
        
       
        self.selectionStyle = .none
        
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.initializeReviewerProfileImage()
        }
        
        guard let reviews = reviews,
            let profileImageString = reviews.userData.reviewerImageURL else { return }
        
        
        
        RestaurantReviewController.getReviewerImage(imageStringURL: profileImageString) { (image) in
            if let image = image {
                let fetchedImage = image
                DispatchQueue.main.async {
                    
                    
                    self.reviewerProfileImage.image = fetchedImage
                    self.reviewerName.text = reviews.userData.reviewerName
                    self.reviewTextLabel.text = reviews.reviewText
                    self.reviewDateLabel.text = Date.getFormattedDate(string: reviews.reviewTimestamp)
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            
        }
    }
}

extension Notification.Name {
    static let sendBusiness = Notification.Name("sendBusiness")
}

extension Date {
    static func getFormattedDate(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // This format is input formated .
        
        guard let formateDate = dateFormatter.date(from:"2018-02-02 06:50:16") else {
            
            return "No date found"
        }
        
        dateFormatter.dateFormat = "MMM dd yyyy" // Output Formated
        
        print ("Print :\(dateFormatter.string(from: formateDate))")//Print :02-02-2018
        return dateFormatter.string(from: formateDate)
    }
}


