//
//  AboutRestaurantController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import MapKit

protocol AboutRestaurantViewControllerDelegate: class {
    func didUpdateAboutRestaurantVC(sender: AboutRestaurantViewController)
}

class AboutRestaurantViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    weak var delegate: AboutRestaurantViewControllerDelegate?
    var restaurantDetails: Businesses?
    private let locationManager = CLLocationManager()
    var restaurantCoordinates: CLLocationCoordinate2D? {
        didSet {
            setupMapView()
        }
    }
    
    // MARK: - View Lifecycle
    override func loadView() {
        super.loadView()
        
        mapView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.didUpdateAboutRestaurantVC(sender: self)
        updateViews()
        StoreFeedbackHelper.askForReview()
    }
    
    private func setupMapView() {
        guard let coordinates =  restaurantCoordinates else {
            return
        }
        
        if let restaurant = restaurantDetails {
            let address = restaurant.location?.displayAddress.first ?? ""
            let distance = restaurant.restaurantDistance?.inMiles ?? 0
            
            
            DispatchQueue.main.async {
                self.addressLabel.text = address
                self.distanceLabel.text = distance == 0 ? "" : "\(distance) miles away"
            }
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        
        DispatchQueue.main.async {
            self.mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func updateViews() {
        guard let restaurantDetails = restaurantDetails else {
            return
        }
        
        guard let phoneNumber = restaurantDetails.restaurantPhone, !phoneNumber.isEmpty else {
            self.phoneButton.setTitle("   No phone number", for: .normal)
            return
        }
        
        DispatchQueue.main.async {
            self.phoneButton.setTitle("   \(phoneNumber)", for: .normal) // TODO: Refactor - replace using " " for spacing
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "pin")
        
        return annotationView
    }
    
    // MARK: - IBActions
    @IBAction func callButtonTapped(_ sender: UIButton) {
        // TODO: - Replace deprecated OpenURL code.
        guard let phoneNumber = phoneButton.currentTitle?.digitsOnly else {
            return
        }
        OpenUrlHelper.call(phoneNumber: phoneNumber)
    }
}
