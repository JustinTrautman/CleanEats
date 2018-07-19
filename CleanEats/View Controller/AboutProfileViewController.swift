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

class AboutProfileViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var webAddressButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    var restaurant: RestaurantDetails?
    var restaurantInfo: Businesses?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        updateViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func populateMapWithRestaurant() {
        let span = MKCoordinateSpanMake(0.012, 0.012)
//        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.mapView., longitude: <#T##CLLocationDegrees#>), span: <#T##MKCoordinateSpan#>)
    }
    
    func updateViews() {
        
        guard let address = restaurant?.location,
              let phone = restaurantInfo?.restaurantPhone else { return }
        
        addressButton.setTitle("\(address)", for: .normal)
        phoneButton.setTitle("\(phone)", for: .normal)
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
