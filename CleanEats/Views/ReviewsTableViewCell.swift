//
//  ReviewsTableViewCell.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var reviews: Reviews? {
        didSet {
            updateViews()
        }
    }
    var businesses: Businesses? {
        didSet {
            updateViews()
        }
    }
    
    
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
    
    
    
    func initializeReviewerProfileImage() {
        
        reviewerProfileImage.layer.cornerRadius = reviewerProfileImage.frame.size.width / 2
        reviewerProfileImage.clipsToBounds = false
        reviewerProfileImage.layer.masksToBounds = true
        
        self.selectionStyle = .none
        
    }
    
    func updateViews() {
        
        DispatchQueue.main.async {
            
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
                    self.reviewDateLabel.text = Date.getFormattedDate(oldDateString: reviews.reviewTimestamp)
                    self.ratingImageView.image = reviews.imageForRating
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                print(reviews.reviewText)
            }
            
        }
    }
}
// Notification for ReviewsViewController
extension Notification.Name {
    static let sendBusiness = Notification.Name("sendBusiness")
}

extension Date {
    static func getFormattedDate(oldDateString: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // This format is input formatted .
        
        guard let formatDate = dateFormatter.date(from: oldDateString) else {
            
            return "No date found"
        }
        
        dateFormatter.dateFormat = "MM/dd/yyyy" // Output Formated
        
        print ("Print :\(dateFormatter.string(from: formatDate))")
        return dateFormatter.string(from: formatDate)
    }
}

