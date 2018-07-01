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
    private let dataProvider = RestaurantSearch()
    private let searchRadius: Double = 5000
    
    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Request User location - Remove later
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()

        setupMapView()
        initGoogleMaps()
    }
    
    // MARK: - Required Google Map Delegate Functions
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
    
    // MARK: - Configuring the map's layout
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

// MARK - : Populating the MapView
private func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
    
    MapView.clear()
    
    dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes) { places in
        places.forEach {
            let marker = PlaceMarker(place: $0)
            marker.map = self.mapView
            }
        }
  }
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
        
        fetchNearbyPlaces(coordinate: location.coordinate)
        myMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}
