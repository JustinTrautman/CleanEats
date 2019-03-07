//
//  RestaurantProfileViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import MapKit

class RestaurantProfileViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: Properites
    var businesses: Businesses?
    var restaurantDetails: RestaurantDetails?
    var mapAddress: String?
    
    // TODO: Move to extension
    var dateComponents: DateComponents {
        let now = Date()
        let components = Calendar.current.dateComponents([.day, .hour, .minute, .weekday], from: now)
        return components
    }
    
    // MARK: - IBOutlets
    @IBOutlet var restaurantProfileView: UIView!
    @IBOutlet weak var favoriteStar: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var slideScrollView: UIScrollView!{
        didSet {
            slideScrollView.delegate = self
        }
    }
    
    @IBOutlet weak var slidePageControl: UIPageControl!
    @IBOutlet weak var ratingStar: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var totalReviewsLabel: UILabel!
    @IBOutlet weak var hoursOfOperationLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var aboutContainerView: UIView!
    @IBOutlet weak var healthRatingContainerView: UIView!
    @IBOutlet weak var reviewContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        fetchRestaurantHealthInspections()
        
        let aboutVC = AboutProfileViewController()
        self.addChild(aboutVC)
        
        StoreFeedbackHelper.askForReview()
    }
    
    // Horizontal ScrollView
    var restaurantPhotos: [UIImage] = []
    
    func createSlides() -> [Slide] {
        
        var slides: [Slide] = []
        
        for photo in restaurantPhotos{
            
            let slide: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.slideImageView.contentMode = .scaleAspectFill
            slide.slideImageView.clipsToBounds = true
            slide.slideImageView.image = photo
            slides.append(slide)
        }
        return slides
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        slideScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        slideScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        slideScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            slideScrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        slidePageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let _: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let _: CGFloat = currentVerticalOffset / maximumVerticalOffset
    }
    
    // MARK: - IBActions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        let getIndex = segmentedControl.selectedSegmentIndex
        
        switch getIndex {
        case 0:
            aboutContainerView.isHidden = false
            healthRatingContainerView.isHidden = true
            reviewContainerView.isHidden = true
        case 1:
            aboutContainerView.isHidden = true
            healthRatingContainerView.isHidden = false
            reviewContainerView.isHidden = true
        case 2:
            aboutContainerView.isHidden = true
            healthRatingContainerView.isHidden = true
            reviewContainerView.isHidden = false
            
            guard let restaurant = businesses else { return }
            NotificationCenter.default.post(name: .sendBusiness, object: restaurant, userInfo: nil)
            
        default:
            break
        }
    }
    
    @IBAction func favoriteStarButtonTapped(_ sender: UIButton) {
        
        if  favoriteStar.isEnabled {
            favoriteStar.setImage(#imageLiteral(resourceName: "FavoriteStarFilled"), for: .normal)
            saveNewFavorite()
            showFavoriteSavedAlert()
            FavoritesViewController.shared.updateTableView()
            print("Star button tapped once")
            favoriteStar.isSelected = false
        }
        
        if  !favoriteStar.isEnabled {
            favoriteStar.setImage(#imageLiteral(resourceName: "Favicon1"), for: .disabled)
            showFavoriteRemovedAlert()
            deleteFavorite()
            print("Star button tapped twice")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aboutProfile" {
            guard let destinationVC = segue.destination as? AboutProfileViewController else { return }
            
            destinationVC.businesses = businesses
            
            guard let longitude = businesses?.coordinate?.longitude,
                let lat = businesses?.coordinate?.latitude
                else { return }
            
            destinationVC.restaurantCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: longitude)
        }
        
        if segue.identifier == "toHealthTV" {
            guard let destinationTV = segue.destination as? HealthRatingTableViewController else { return }
            
            destinationTV.restaurants = businesses
            
            // ✅ TODO: Pass data over Notification Center. It takes a bit of time to fetch the records
            // From the database so send a notification when it is done.
        }
    }
    
    // Favorite star logic
    func saveNewFavorite() {
        //        guard let criticalViolations = criticalViolations,
        //            let nonCriticalViolations = nonCriticalViolations,
        //            let rating = businesses?.restaurantRating else { return }
        
        //        let totalViolations = criticalViolations.count + nonCriticalViolations.count
        //
        //        if let descriptionCategories = businesses?.categories {
        //            if let description1 = descriptionCategories[0].title {
        //
        //                let image = restaurantPhotos[0]
        //                guard let name = restaurantNameLabel.text,
        //                    let phone = businesses?.restaurantPhone else { return }
        //
        //                // Register default image
        //                UserDefaults.standard.register(defaults: ["key": UIImage.jpegData(image)])
        //
        //                // Save image to UserDefaults
        //                UserDefaults.standard.set(UIImage.jpegData(image), forKey: "key")
        //
        //                FavoriteController.shared.create(image: "Image", name: name, healthScore: "\(totalViolations)", rating: "\(rating)", phone: phone, description: "\(description1)")
        //            }
        //        }
    }
    
    func deleteFavorite() {
        
        // TODO: - Impelement favorite delete function
    }
    
    func showFavoriteSavedAlert() {
        let favoriteSavedAlert = UIAlertController(title: nil, message: "Restaurant successfully added to your favorites!", preferredStyle: .alert)
        favoriteSavedAlert.addAction(UIAlertAction(title: "Sweet!", style: .default, handler: nil))
        self.present(favoriteSavedAlert, animated: true)
    }
    
    func showFavoriteRemovedAlert() {
        let favoriteRemovedAlert = UIAlertController(title: nil, message: "Restaurant successfully removed from your favorites.", preferredStyle: .alert)
        favoriteRemovedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(favoriteRemovedAlert, animated: true)
    }
    
    func showNoHealthDataAlert() {
        guard let restaurantName = restaurantNameLabel.text else { return }
        let noHealthDataAlet = UIAlertController(title: nil, message: "Sorry, no health data was found for \(restaurantName)", preferredStyle: .alert)
        noHealthDataAlet.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(noHealthDataAlet, animated: true)
    }
    
    func showLoadingHealthDataAlert() {
        
        let loadingAlert = UIAlertController(title: nil, message: "Testing...", preferredStyle: .alert)
        
        loadingAlert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        
        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true, completion: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateViews() {
        // Image carousel setup
        view.addSubview(scrollView)
        slideScrollView.delegate = self
        slidePageControl.currentPage = 0
        scrollView.contentSize = CGSize(width: 375, height: 800)
//        scrollView.bringSubviewToFront(favoriteStar)
        
        // Text label setup
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 5
        
        if let business = businesses {
            guard let restuarantAlias = business.alias else { return }
            
            RestaurantDetailController.fetchRestaurantDetailsWith(restaurantAlias: restuarantAlias) { (restaurantDetails) in
                guard restaurantDetails != nil else { return }
                let name = restaurantDetails?.name
                guard let totalReviews = restaurantDetails?.reviewCount else { return }
                let starRatingView = restaurantDetails?.imageForRating
                
                guard let photoUrls = restaurantDetails?.photos else { return }
                
                let photosGroup = DispatchGroup()
                
                for url in photoUrls{
                    photosGroup.enter()
                    RestaurantDetailController.fetchRestaurantPhoto(imageStringURL: url, completion: { (photo) in
                        guard let photo = photo else {return}
                        self.restaurantPhotos.append(photo)
                        photosGroup.leave()
                    })
                }
                
                photosGroup.notify(queue: .main){
                    let slides = self.createSlides()
                    self.slidePageControl.numberOfPages = slides.count
                    self.setupSlideScrollView(slides: slides)
                    self.restaurantNameLabel.text = name
                    self.totalReviewsLabel.text  = ("(\(String(describing: totalReviews)))")
                    self.ratingStar.image = starRatingView
                }
            }
        }
    }
    
    func fetchRestaurantHealthInspections() {
        guard let address = mapAddress else {
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            HealthInspectionController.fetchHealthInspectionFor(restaurantAddress: address) { (inspections) in
                if let inspections = inspections {
                    let healthInspections = ["inspections": inspections]
                    
                    NotificationCenter.default.post(name: Constants.healthInspectionKey, object: nil, userInfo: healthInspections)
                }
            }
        }
    }
}
