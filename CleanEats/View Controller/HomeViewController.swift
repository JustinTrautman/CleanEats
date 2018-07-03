//
//  HomeViewController.swift
//  showRestaurantOnMap
//
//  Created by Huzaifa Gadiwala on 30/6/18.
//  Copyright © 2018 Huzaifa Gadiwala. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, UISearchBarDelegate {

    // Outlets
    @IBOutlet weak var searchBarMap: UISearchBar!
    @IBOutlet weak var homeMapView: MKMapView!
    
    // Propeties
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeMapView.showsUserLocation = true
        searchBarMap.backgroundImage = UIImage()
        searchBarMap.delegate = self
        searchBarMap.layer.cornerRadius = 4
        searchBarMap.clipsToBounds = true
        searchBarMap.layer.shadowColor = UIColor.darkGray.cgColor
        searchBarMap.layer.shadowOffset = CGSize(width: 1, height: 1)
        searchBarMap.layer.shadowRadius = 2
        searchBarMap.layer.shadowOpacity = 0.65
        configureLocationServices()
        let scale = MKScaleView(mapView: homeMapView)
        scale.scaleVisibility = .visible // always visible
        view.addSubview(scale)
        
        setupNavigationBarItems()
    }

    // Adding Image to Navigation Item
    func setupNavigationBarItems() {
        let logo = UIImage(named: "DineRiteNew")
                var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
                imageView = UIImageView(image: logo)
                imageView.contentMode = .scaleAspectFit
                self.navigationItem.titleView = imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       searchBarMap.resignFirstResponder()
        // Ignoring user interaction while provding search result
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBarMap.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("error")
            } else {
                
                // Remove current annotations on map
                let annotations = self.homeMapView.annotations
                self.homeMapView.removeAnnotations(annotations)
            
                // Getting data
                guard let latitude = response?.boundingRegion.center.latitude else {return}
                guard let longitude = response?.boundingRegion.center.longitude else {return}
            
                // Creating annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.searchBarMap.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                self.homeMapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.homeMapView.setRegion(region, animated: true)
            }
        }
        
    }
    
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
        homeMapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
        homeMapView.setRegion(zoomRegion, animated: true)
    }
}


extension HomeViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        
        currentCoordinate = latestLocation.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("The status changed")
    
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
        
    }
    

}
