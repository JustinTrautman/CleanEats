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

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

class GoogleMapViewController: UIViewController, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {
    
    @IBOutlet var MapView: GMSMapView!
    
    // MARK: - Properties
   // static let sharedMapController = GoogleMapViewController()
    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // myMapView.delegate = self
        locationManager.delegate = self
        // restaurantSearchBar?.delegate = self
        locationManager.requestWhenInUseAuthorization() // Request User location - Remove later
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()

        setupMapView()
        initGoogleMaps()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        myMapView.camera = camera
        chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "\(place.name)"
        marker.snippet = "\(place.formattedAddress!)"
        marker.map = myMapView
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error autocompleting address error: \(error) \(error.localizedDescription)")
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 47.6588, longitude: -117.4260, zoom: 17.0)
        self.myMapView.camera = camera
        self.myMapView.delegate = self
        self.myMapView.isMyLocationEnabled = true
    }

    func setupMapView() {
        
            view.addSubview(myMapView)
            myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive = true
        }
    
        let myMapView: GMSMapView = {
            let v = GMSMapView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
}

// MARK: - CLLocationManagerDelegate
extension GoogleMapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        myMapView.isMyLocationEnabled = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        myMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        locationManager.stopUpdatingLocation()
    }
}
