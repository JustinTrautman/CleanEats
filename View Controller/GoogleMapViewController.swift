//
//  GoogleMapViewController.swift
//  CleanEats
//
//  Created by Justin Trautman on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapViewController: UIViewController {
    
    // MARK: - Properties
    let restaurantSearchBar = SearchPageViewController.sharedPageView.restaurantSearchBar
    
    // MARK: - Outlets
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

       setupMapView()
    }
    
    func setupMapView() {
        
        GMSServices.provideAPIKey("AIzaSyBHh-f0KqLhwy828wB7HUYLOt81w4FhmZw")
        GMSPlacesClient.provideAPIKey("AIzaSyBHh-f0KqLhwy828wB7HUYLOt81w4FhmZw")
        
        let camera = GMSCameraPosition.camera(withLatitude: 47.6588, longitude: -117.4260, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 47.6588, longitude: -117.4260)
        marker.title = "Spokane"
        marker.snippet = "Washington"
        marker.map = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
