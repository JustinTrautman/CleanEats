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
    
    var violationTitles: [String?] = []
    var criticalViolations: [Int]? = []
    var nonCriticalViolations: [Int]? = []
    var inspectionDates: [String]? = []
    var violationCodes: [String]? = []
    var violationWeights: [Int]? = []
    
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
        
        guard let criticalTotal = HealthViolationData.shared.criticalViolations?.count,
            let nonCriticalTotal = HealthViolationData.shared.nonCriticalViolations?.count else { return }
        
        // Image carousel setup
        view.addSubview(scrollView)
        slideScrollView.delegate = self
        slidePageControl.currentPage = 0
        scrollView.contentSize = CGSize(width: 375, height: 800)
        view.bringSubview(toFront: slidePageControl)
        
        // Text label setup
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 5
        scoreLabel.text = "\(criticalTotal + nonCriticalTotal)"
        
        let aboutVC = AboutProfileViewController()
        self.addChildViewController(aboutVC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateView()
        
//        showLoadingHealthDataAlert()
        
        // Prepares health data for use to speed up parsing
        print("Serializing health data...")
        HealthDataController.shared.serializeHealtData()
        print("Done serializing health data")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
            print("First Segment Selected")
            aboutContainerView.isHidden = false
            healthRatingContainerView.isHidden = true
            reviewContainerView.isHidden = true
            
        case 1:
            print("Second Segment Selected")
            aboutContainerView.isHidden = true
            healthRatingContainerView.isHidden = false
            reviewContainerView.isHidden = true
        
        case 2:
            print("Third segment selected")
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
        guard let name = restaurantNameLabel.text,
            let healthScore = scoreLabel.text,
            let phone = businesses?.restaurantPhone else { return }
        
        saveNewFavorite()
        
        if  favoriteStar.isEnabled {
            favoriteStar.setImage(#imageLiteral(resourceName: "FavoriteStarFilled"), for: .normal)
            showFavoriteSavedAlert()
            FavoriteViewController.shared.updateTableView()
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
        }
    }
    
    // Favorite star logic
    func saveNewFavorite() {
        
        guard let desriptionCategories = businesses?.categories else { return }
        
        let description1 = desriptionCategories[0].title
        let description2 = desriptionCategories[1].title
        let description3 = desriptionCategories[2].title
        
        let image = restaurantPhotos[0]
        guard let name = restaurantNameLabel.text,
            let phone = businesses?.restaurantPhone else { return }
        
        FavoriteController.shared.create(image: "Image", name: name, healthScore: "5", rating: "5", phone: phone, description: "\(description1); \(description2); \(description3)")
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
    
    func showLoadingHealthDataAlert() {
        
        let loadingAlert = UIAlertController(title: nil, message: "Testing...", preferredStyle: .alert)
        
        loadingAlert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating()
        
        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true, completion: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateView() {
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
                    print("Entering the photos dispatch Group")
                    RestaurantDetailController.fetchRestaurantPhoto(imageStringURL: url, completion: { (photo) in
                        guard let photo = photo else {return}
                        self.restaurantPhotos.append(photo)
                        print("Leaving the photos dispatch Group")
                        photosGroup.leave()
                    })
                }
                
                photosGroup.notify(queue: .main){
                    print("Main Queue Notified")
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
}
