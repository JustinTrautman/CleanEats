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

class HomeViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    
    static var shared = HomeViewController()
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var restaurantObjects: [CustomAnnotation] = []

    // Outlets
    @IBOutlet weak var searchBarMap: UISearchBar!
    @IBOutlet weak var homeMapView: MKMapView!
    
    // Propeties
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    
//    func fromYelp() {
//       RestaurantInfoController.fetchRestaurantInfo(with: searchBarMap.text, andLocation: <#T##String#>, completion: <#T##((Businesses)?) -> Void#>)
//        for objects in RestaurantInfoController.restaurants {
//            print("Name = \(objects.restaurantName ?? "No match")")
//                                    print("Phone = \(objects.restaurantPhone ?? "No Match")")
//
//                                    print("Matching items = \(self.matchingItems.count)")
//
//                                    let annotation = MKPointAnnotation()
//                                    annotation.coordinate = currentCoordinate!
//                                    annotation.title = objects.restaurantName
//                                    annotation.subtitle = objects.restaurantPhone
//
//
//
//        }
//    }
    
    func performSearch() {

        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarMap.text
        request.region = homeMapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if let results = response {
                
                if let err = error {
                    print("Error occurred in search: \(err.localizedDescription)")
                } else if results.mapItems.count == 0 {
                    print("No matches found")
                } else {
                    print("Matches found")
                    
                    // Remove current annotations on map
                                    let annotations = self.homeMapView.annotations
                                    self.homeMapView.removeAnnotations(annotations)
                    
                                    // Getting data
                                    guard let latitude = response?.boundingRegion.center.latitude else {return}
                                    guard let longitude = response?.boundingRegion.center.longitude else {return}
                    
                    for item in results.mapItems {
                        print("Name = \(item.name ?? "No match")")
                        print("Phone = \(item.phoneNumber ?? "No Match")")

                        self.matchingItems.append(item as MKMapItem)
                        print("Matching items = \(self.matchingItems.count)")

                        let annotation = MKPointAnnotation()
                        annotation.coordinate = item.placemark.coordinate
                        annotation.title = item.name
                        annotation.subtitle = item.phoneNumber
                        let point = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude , longitude: longitude ))
                        point.restaurantName = item.name
                        //point.restaurantPrice =



                        self.homeMapView.addAnnotation(annotation)

                        //Zooming in on annotation
                        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                        let span = MKCoordinateSpanMake(0.01, 0.01)
                        let region = MKCoordinateRegionMake(coordinate, span)
                        self.homeMapView.setRegion(region, animated: true)
                        
                    }
                }
            }
        })
    }
    


    // Adding custom pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        
        if annotation is MKUserLocation {
            return nil
        }
        let annotationView =  MKAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = true
        
//        joesFunction(annotationView)
        
        return annotationView
    }
    
//    func joesFunction(_ annotationView: MKAnnotationView) {
//        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        let redSquare = UIView(frame: frame)
//        redSquare.backgroundColor = UIColor.red
//        annotationView.detailCalloutAccessoryView = redSquare
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeMapView.showsUserLocation = true
        homeMapView.delegate = self
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
       // populateNearByPlaces()
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
    
    // Action for the searchBar on the MAP
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       searchBarMap.resignFirstResponder()
//        // Ignoring user interaction while provding search result
//        UIApplication.shared.beginIgnoringInteractionEvents()
//
//        // Activity Indicator
//        let activityIndicator = UIActivityIndicatorView()
//        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.startAnimating()
//
//        self.view.addSubview(activityIndicator)
//
//        //Create the search request
//        let searchRequest = MKLocalSearchRequest()
//        searchRequest.naturalLanguageQuery = searchBarMap.text
//
//        let activeSearch = MKLocalSearch(request: searchRequest)
//
//        activeSearch.start { (response, error) in
//
//            activityIndicator.stopAnimating()
//            UIApplication.shared.endIgnoringInteractionEvents()
//            if response == nil {
//                print("error")
//            } else {
//                // Remove current annotations on map
//                let annotations = self.homeMapView.annotations
//                self.homeMapView.removeAnnotations(annotations)
//
//                // Getting data
//                guard let latitude = response?.boundingRegion.center.latitude else {return}
//                guard let longitude = response?.boundingRegion.center.longitude else {return}
//
//                // Creating annotation
//                let annotation = MKPointAnnotation()
//                annotation.title = self.searchBarMap.text
//                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
//                self.homeMapView.addAnnotation(annotation)
//
//                //Zooming in on annotation
//                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
//                let span = MKCoordinateSpanMake(0.1, 0.1)
//                let region = MKCoordinateRegionMake(coordinate, span)
//                self.homeMapView.setRegion(region, animated: true)
//            }
//        }
       performSearch()
      //  fromYelp()
    }
    
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
