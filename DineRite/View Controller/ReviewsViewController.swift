//
//  ReviewsTableViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import SafariServices

class ReviewsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    // MARK: - Properties
    var businesses: Businesses?
    
    // MARK: IBOutlets
    @IBOutlet weak var reviewsTableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        reviewsTableView.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchReviews()
        listenForUnwindSegue()
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
            self.reviewsTableView.reloadData()
        }
    }
    
    func listenForUnwindSegue() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleUnwindSegue), name: Constants.reviewUnwindKey, object: nil)
    }
    
    
    // MARK: Hanlers
    @objc func handleYelpButtonTap() {
        // ✅ TODO: See if API call returns a specific url for the restaurant. Replace this with that.
        let restuarantUrl = businesses?.yelpUrl ?? "https://www.yelp.com"
        OpenUrlHelper.openWebsite(with: restuarantUrl, on: self)
    }
    
    @objc func handleUnwindSegue() {
        RestaurantReviewController.shared.reviews.removeAll()
        self.reloadTableView()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ReviewDetailViewController.segueIdentifier {
            if let indexPath = reviewsTableView.indexPathForSelectedRow {
                guard let detailVC = segue.destination as? ReviewDetailViewController else {
                    assertionFailure()
                    return
                }
                
                let selectedReview = RestaurantReviewController.shared.reviews[indexPath.row]
                detailVC.review = selectedReview
            }
        }
    }
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantReviewController.shared.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewsTableViewCell
        let review = RestaurantReviewController.shared.reviews[indexPath.row]
        cell.reviews = review
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
