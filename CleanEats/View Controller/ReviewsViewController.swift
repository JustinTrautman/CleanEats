//
//  ReviewsTableViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    
    // MARK: - Properties
    var businesses: Businesses?
    let reviews: [Reviews] = []
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var reviewsTableViewController: UITableView!
    @IBOutlet weak var yelpButton: UIButton!
    @IBOutlet weak var viewForYelpButton: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(businessSent), name: .sendBusiness, object: nil)
        
        reviewsTableViewController.delegate = self
        reviewsTableViewController.dataSource = self
        initializeYelpButtonView()
        fetchReviews()
        reloadTableView()
        
    }
    
    @objc func businessSent(notification: Notification) {
        guard let business = notification.object as? Businesses else { return }
        self.businesses = business
        fetchReviews()
    }
    
    func fetchReviews() {
        
        if let business = businesses {
            guard let businessRestaurantID = business.restaurantID else { return }
            
            RestaurantReviewController.shared.fetchRestaurantReview(withID: businessRestaurantID) { (review) in
                guard let _ = review else { return }
                
                self.reloadTableView()
            }
        }
    }
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.reviewsTableViewController.tableFooterView = UIView()
            self.reviewsTableViewController.reloadData()
            
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func yelpButtonTapped(_ sender: Any) {
        openYelpURL(urlStr: "http://www.yelp.com")
        print("yelp button tapped")
    }
    
    
    func initializeYelpButtonView() {
        
        viewForYelpButton.clipsToBounds = true
        viewForYelpButton.layer.masksToBounds = false
        viewForYelpButton.layer.shadowRadius = 7.0
        viewForYelpButton.layer.shadowColor = UIColor.lightGray.cgColor
        viewForYelpButton.layer.shadowOpacity = 0.4
        viewForYelpButton.layer.shadowOffset = CGSize.zero
        viewForYelpButton.layer.shouldRasterize = true
    }
    
    func openYelpURL(urlStr: String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}

extension ReviewsViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return RestaurantReviewController.shared.reviews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewsTableViewCell
        let review = RestaurantReviewController.shared.reviews[indexPath.row]
        cell.reviews = review
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 170
        } else {
            return 170
        }
    }
    
}



