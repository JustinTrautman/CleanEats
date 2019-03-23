//
//  RestaurantProfileViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher
import CoreData

class RestaurantProfileViewController: UIViewController, UIScrollViewDelegate {
    // MARK: Properites
    var restaurants: Businesses?
    var restaurantDetails: RestaurantDetails?
    var mapAddress: String?
    var healthInspections: [HealthInspection] = []
    
    lazy var totalInspectionPoints = 0 // This is the total accumulated violation points received during inspections (less is better).
    lazy var closingTimeAttributedText = NSMutableAttributedString()
    lazy var restaurantPhotos: [UIImage] = []
    
    // Container Views
    private lazy var aboutViewController: AboutRestaurantViewController = {
        let storyboard = UIStoryboard(name: "AboutRestaurant", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AboutProfileViewController") as! AboutRestaurantViewController
        self.addChild(viewController)
        return viewController
    }()
    
    private lazy var healthInspectionTableViewController: HealthInspectionTableViewController = {
        let storyboard = UIStoryboard(name: "HealthInspection", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "HealthInspectionTableViewController") as! HealthInspectionTableViewController
        self.addChild(viewController)
        return viewController
    }()
    
    private lazy var reviewViewController: ReviewsViewController = {
        let storyboard = UIStoryboard(name: "Review", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController") as! ReviewsViewController
        self.addChild(viewController)
        return viewController
    }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Favorite> = {
        let internalFetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        internalFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        return NSFetchedResultsController(fetchRequest: internalFetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    let favoriteStarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoriteStar"), for: .normal)
        button.setImage(UIImage(named: "favoriteStarFilled"), for: .selected)
        button.addTarget(self, action: #selector(handleFavoriteStarTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - IBOutlets
    @IBOutlet var restaurantProfileView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var slideScrollView: UIScrollView!{
        didSet {
            slideScrollView.delegate = self
        }
    }
    
    @IBOutlet weak var slidePageControl: UIPageControl!
    @IBOutlet weak var ratingStarImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var totalReviewsLabel: UILabel!
    @IBOutlet weak var hoursOfOperationLabel: UILabel!
    @IBOutlet weak var totalHealthScoreLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        setupNavigationBarItems()
        setupSegmentedControl()
        updateContainerView()
        fetchRestaurantHealthInspections()
        fetchAllFavorites()
        setupFavoriteStarButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            NotificationCenter.default.post(name: Constants.reviewUnwindKey, object: nil)
        }
    }
    
    // MARK: Programatic View Setup
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
            slidePageControl.bringSubviewToFront(slidePageControl)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        slidePageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        let _: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let _: CGFloat = currentVerticalOffset / maximumVerticalOffset
    }
    
    func setupNavigationBarItems() {
        let logo = UIImage(named: "DineRiteNew")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func setupFavoriteStarButton() {
        scrollView.addSubview(favoriteStarButton)
        scrollView.bringSubviewToFront(favoriteStarButton)
        
        favoriteStarButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteStarButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        favoriteStarButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        favoriteStarButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        favoriteStarButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "About", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Inspections", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Reviews", at: 2, animated: false)
        segmentedControl.addTarget(self, action: #selector(handleSegmentSelectionChange(_:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    func updateContainerView() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let mapCoordinates = CLLocationCoordinate2D(latitude: restaurants?.coordinate?.latitude ?? 0, longitude: restaurants?.coordinate?.longitude ?? 0)
            aboutViewController.restaurantDetails = restaurants
            aboutViewController.restaurantCoordinates = mapCoordinates
            removeActiveContainerView()
            self.addChildContainer(viewController: aboutViewController)
        case 1:
            healthInspectionTableViewController.restaurantDetails = restaurants
            healthInspectionTableViewController.healthInspections = healthInspections
            removeActiveContainerView()
            self.addChildContainer(viewController: healthInspectionTableViewController)
        case 2:
            guard let restuarantDetails = restaurants else { return }
            reviewViewController.restaurants = restuarantDetails
            removeActiveContainerView()
            self.addChildContainer(viewController: reviewViewController)
        default:
            fatalError("The selected segment index calls for an unrecognized container view.")
        }
    }
    
    private func addChildContainer(viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func removeChildContainer(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func removeActiveContainerView() {
        for view in containerView.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func checkFavoriteStatus() {
        guard let restaurant = restaurantDetails, let favorites = fetchedResultsController.fetchedObjects else { return }
        
        for favorite in favorites {
            if favorite.name == restaurant.name {
                DispatchQueue.main.async {
                    self.favoriteStarButton.setImage(#imageLiteral(resourceName: "FavoriteStarFilled"), for: .normal)
                    self.favoriteStarButton.isSelected = true
                }
            }
        }
    }
    
    func updateViews() {
        // Image carousel setup
        slideScrollView.delegate = self
        slidePageControl.currentPage = 0
        
        if let business = restaurants {
            guard let restuarantAlias = business.alias else { return }
            
            RestaurantDetailController.fetchRestaurantDetailsWith(restaurantAlias: restuarantAlias) { (restaurantDetails) in
                guard let currentRestuarant = restaurantDetails else {
                    return
                }
                
                self.restaurantDetails = restaurantDetails
                self.checkFavoriteStatus()
                
                let name = currentRestuarant.name
                let totalReviews = currentRestuarant.reviewCount
                let rating = currentRestuarant.rating?.roundToClosestHalf() ?? 0
                
                if let hours = currentRestuarant.hours?.first {
                    let closingTime = RestaurantHoursHelper.returnClosingTime(for: hours)
                    self.closingTimeAttributedText
                        .bold("Open until- ")
                        .normal(closingTime)
                }
                
                guard let photoUrls = restaurantDetails?.photos else { return }
                
                let photosGroup = DispatchGroup()
                
                for url in photoUrls{
                    photosGroup.enter()
                    let imageUrl = URL(string: url)
                    
                    DispatchQueue.main.async {
                        KingfisherManager.shared.retrieveImage(with: imageUrl!, completionHandler: { (result) in
                            switch result {
                            case .success(let value):
                                self.restaurantPhotos.append(value.image)
                                photosGroup.leave()
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        })
                    }
                }
                
                photosGroup.notify(queue: .main) {
                    let slides = self.createSlides()
                    self.slidePageControl.numberOfPages = slides.count
                    self.setupSlideScrollView(slides: slides)
                    self.slideScrollView.bringSubviewToFront(self.slidePageControl)
                    
                    DispatchQueue.main.async {
                        self.totalHealthScoreLabel.layer.masksToBounds = true
                        self.totalHealthScoreLabel.layer.cornerRadius = 5
                        self.restaurantNameLabel.text = name
                        self.totalReviewsLabel.text  = "(\(totalReviews))"
                        self.ratingStarImageView.image = StarRatingHelper.returnStarFrom(rating: rating)
                        self.hoursOfOperationLabel.attributedText = self.closingTimeAttributedText
                    }
                }
            }
        }
    }
    
    // MARK: CRUD and Fetcher Functions
    private func fetchAllFavorites() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing fetch from results controller. \(error.localizedDescription)")
        }
    }
    
    func removeFavorite(withName: String) {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", withName)
        
        do {
            let favorites = try CoreDataStack.context.fetch(fetchRequest)
            for favorite in favorites {
                FavoriteController.delete(favorite: favorite)
            }
        } catch {
            print(error)
        }
    }
    
    func fetchRestaurantHealthInspections() {
        guard let address = mapAddress else {
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            HealthInspectionController.getHealthInspectionsFor(address: address, completion: { [unowned self] (inspections) in
                if let inspections = inspections {
                    self.healthInspections = inspections
                    
                    for inspection in inspections {
                        self.totalInspectionPoints += inspection.weight ?? 0
                    }
                    DispatchQueue.main.async {
                        self.totalHealthScoreLabel.text = String(describing: self.totalInspectionPoints)
                    }
                }
            })
        }
    }
}
