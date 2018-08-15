//
//  AboutProfileViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol AboutProfileViewControllerDelegate: class {
    func didUpdateAboutProfileVC(sender: AboutProfileViewController)
}

class AboutProfileViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var webAddressButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    
    var businesses: Businesses?
    
    weak var delegate: AboutProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        delegate?.didUpdateAboutProfileVC(sender: self)
        updateViews()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        mapView.setRegion(MKCoordinateRegion(center: restaurantCoordinates!, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        guard let  restaurantCoordinates = restaurantCoordinates else { return }
        guard let businesses  = businesses else {return}
        let point = CustomAnnotation(coordinate: restaurantCoordinates, restaurant: businesses)
        
        
        self.mapView.addAnnotations([point])
    }
    
    // MARK: - IBActions
    @IBAction func callButtonTapped(_ sender: UIButton) {
    }
    @IBAction func addressButtonTapped(_ sender: UIButton) {
    }
    @IBAction func webAddressButtonTapped(_ sender: UIButton) {
    }
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    var restaurantCoordinates: CLLocationCoordinate2D?

    func updateViews() {
        guard let businesses = businesses,
            let phone = businesses.restaurantPhone, let address = businesses.location?.address1, let yelpUrl = businesses.yelpUrl else { return }
        
        phoneButton.setTitle("      \(phone)", for: .normal)
        addressButton.setTitle("      \(address)", for: .normal)
        webAddressButton.setTitle("      \(yelpUrl)", for: .normal)

        
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
    
}

class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
    
}

