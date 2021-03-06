 //
 //  SearchPageViewController.swift
 //  CleanEats
 //
 //  Created by Justin Trautman on 6/27/18.
 //  Copyright © 2018 Justin Trautman. All rights reserved.
 //
 
 import UIKit
 import MapKit
 
 class DiscoverViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var findFoodButton: UIButton!
    @IBOutlet weak var fastFoodButton: UIButton!
    @IBOutlet weak var deliveryButton: UIButton!
    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var foodTruckButton: UIButton!
    @IBOutlet weak var cafeButton: UIButton!
    @IBOutlet weak var groceryButton: UIButton!
    @IBOutlet weak var restaurantMapView: MKMapView!
    @IBOutlet weak var restaurantTableView: UITableView!
    
    // MARK: - Actions
    @IBAction func findFoodButtonTapped(_ sender: UIButton) {
        restaurantSearchBar.text = ""
        restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        reloadRestaurantTableView()
        populateNearbyPlaces()
        restaurantSearchBar.resignFirstResponder()
    }
    
    @IBAction func fastFoodButtonTapped(_ sender: Any) {
        clearFilterButtons()
        restaurantSearchBar.text = ""
        fastFoodButton.isSelected = true
        populateNearbyPlaces()
        restaurantSearchBar.resignFirstResponder()
    }
    
    @IBAction func deliveryButtonTapped(_ sender: Any) {
        clearFilterButtons()
        restaurantSearchBar.text = ""
        deliveryButton.isSelected = true
        populateNearbyPlaces()
        restaurantSearchBar.resignFirstResponder()
    }
    
    @IBAction func barButtonTapped(_ sender: Any) {
        clearFilterButtons()
        restaurantSearchBar.text = ""
        barButton.isSelected = true
        populateNearbyPlaces()
        restaurantSearchBar.resignFirstResponder()
    }
    
    @IBAction func FoodTruckButtonTapped(_ sender: Any) {
        clearFilterButtons()
        restaurantSearchBar.text = ""
        foodTruckButton.isSelected = true
        populateNearbyPlaces()
        restaurantSearchBar.resignFirstResponder()
    }
    
    @IBAction func cafeButtonTapped(_ sender: UIButton) {
        clearFilterButtons()
        restaurantSearchBar.text = ""
        cafeButton.isSelected = true
        populateNearbyPlaces()
        restaurantSearchBar.resignFirstResponder()
    }
    
    @IBAction func groceryButtonTapped(_ sender: UIButton) {
        clearFilterButtons()
        restaurantSearchBar.text = ""
        groceryButton.isSelected = true
        populateNearbyPlaces()
        restaurantSearchBar.resignFirstResponder()
    }
    
    // MARK: - Properties
    var restaurants: [Businesses] = []
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    // View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuring Main SearchView Page
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        initializeFindFoodButton()
        setupNavigationBarItems()
        
        // Restaurant MapView
        restaurantMapView.clipsToBounds = true
        restaurantMapView.showsUserLocation = true
        restaurantMapView.delegate = self
        
        let scale = MKScaleView(mapView: restaurantMapView)
        scale.scaleVisibility = .visible
        view.addSubview(scale)
        populateNearbyPlaces()
        
        // Restaurant SearchBar
        restaurantSearchBar.delegate = self
        
        // Restaurant TableView
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        reloadRestaurantTableView()
    }
    
    // Adding Image to Navigation Item
    func setupNavigationBarItems() {
        let logo = UIImage(named: "DineRiteNew")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func reloadRestaurantTableView() {
        DispatchQueue.main.async {
            self.restaurantTableView.reloadData()
        }
    }
    
    func clearFilterButtons() {
        fastFoodButton.isSelected = false
        deliveryButton.isSelected = false
        barButton.isSelected = false
        foodTruckButton.isSelected = false
        cafeButton.isSelected = false
        groceryButton.isSelected = false
    }
    
    func populateNearbyPlaces() {
        var buttonSelected: Bool = false
        
        let span = MKCoordinateSpan(latitudeDelta: 0.012, longitudeDelta: 0.012)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.restaurantMapView.userLocation.coordinate.latitude, longitude: self.restaurantMapView.userLocation.coordinate.longitude), span: span)
        restaurantMapView.setRegion(region, animated: true)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = restaurantSearchBar.text
        
        if fastFoodButton.isSelected {
            request.naturalLanguageQuery = "Fast Food"
            buttonSelected = true
            restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        }
        
        if deliveryButton.isSelected {
            request.naturalLanguageQuery = "Delivery"
            buttonSelected = true
            restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        }
        
        if barButton.isSelected {
            request.naturalLanguageQuery = "Bar"
            buttonSelected = true
            restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        }
        
        if foodTruckButton.isSelected {
            request.naturalLanguageQuery = "Food Stand"
            buttonSelected = true
            restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        }
        
        if cafeButton.isSelected {
            request.naturalLanguageQuery = "Coffee"
            buttonSelected = true
            restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        }
        
        if groceryButton.isSelected {
            request.naturalLanguageQuery = "Grocery"
            buttonSelected = true
            restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        }
        
        if restaurantSearchBar.text == "" && buttonSelected == false {
            request.naturalLanguageQuery = "restaurants"
            restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        }
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            guard let response = response else {return}
            
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                
                let latitude = annotation.coordinate.latitude
                let longitude = annotation.coordinate.longitude
                
                RestaurantInfoController.fetchRestaurantInfo(withSearchTerm: item.name ?? "restaurant", latitude: latitude, longitude: longitude, completion: { (businesses) in
                    
                    if let businesses = businesses {
                        self.restaurants = businesses
                        DispatchQueue.main.async {
                            self.restaurantTableView.reloadData()
                        }
                    }
                })
                DispatchQueue.main.async {
                    self.restaurantMapView.addAnnotation(annotation)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    func initializeFindFoodButton() {
        findFoodButton?.layer.cornerRadius = 3.0
        findFoodButton?.clipsToBounds = true
        findFoodButton?.layer.shadowRadius = 3.0
        findFoodButton?.layer.shadowColor = UIColor.black.cgColor
        findFoodButton?.layer.shadowOpacity = 1.0
        findFoodButton?.layer.shadowOffset = CGSize(width: 5, height: 5)
        findFoodButton?.layer.masksToBounds = false
        findFoodButton?.backgroundColor = UIColor(displayP3Red: 0.13, green: 0.79, blue: 0.72, alpha: 1)
        findFoodButton?.setTitle("FIND FOOD", for: .normal)
        findFoodButton?.setTitleColor(.white, for: .normal)
        findFoodButton?.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
    }
    
    @objc func startHighlight(sender: UIButton) {
        deliveryButton.layer.borderColor = UIColor.black.cgColor
        deliveryButton.layer.borderWidth = 3
    }
    @objc func stopHighlight(sender: UIButton) {
        deliveryButton.layer.borderColor = UIColor.black.cgColor
        deliveryButton.layer.borderWidth = 1
    }
    
    func showNoResultsAlert() {
        guard let searchedTerm = restaurantSearchBar.text else { return }
        AlertHelper.showNoSearchResultsAlert(vc: self, searchTerm: searchedTerm)
    }
    
    func showNoTextAlert() {
        AlertHelper.showNoSearchTextAlert(vc: self)
    }
 }
 
 extension DiscoverViewController: MKMapViewDelegate {
    
    // Adding custom pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        if annotation is MKUserLocation {
            return nil
        }
        let annotationView =  MKAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = true
        return annotationView
    }
 }
 
 extension DiscoverViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        clearFilterButtons()
        
        reloadRestaurantTableView()
        if restaurantSearchBar.text == "" {
            showNoTextAlert()
        }
        
        restaurantSearchBar.resignFirstResponder()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = restaurantSearchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                self.showNoResultsAlert()
            } else {
                
                let annotations = self.restaurantMapView.annotations
                self.restaurantMapView.removeAnnotations(annotations)
                
                guard let latitude = response?.boundingRegion.center.latitude else { return }
                guard let longitude = response?.boundingRegion.center.longitude else { return }
                
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurantSearchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                self.restaurantMapView.addAnnotation(annotation)
                
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.restaurantMapView.setRegion(region, animated: true)
            }
        }
        populateNearbyPlaces()
    }
 }
 
 extension DiscoverViewController: CLLocationManagerDelegate {
    
    // Function for finding the user location
    func configureLocationServices() {
        locationManager.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .restricted ||
            status == .denied ||
            status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    func beginLocationUpdates(locationManager: CLLocationManager) {
        restaurantMapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        restaurantMapView.setRegion(zoomRegion, animated: true)
    }
 }
 
 extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as? RestaurantTableViewCell else { return UITableViewCell() }
        
        let restaurant = restaurants[indexPath.row]
        cell.restaurants = restaurant
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        restaurantTableView.deselectRow(at: indexPath, animated: true)
    }
 }
