import UIKit
import MapKit
import CoreLocation
class HomeViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    static var shared = HomeViewController()
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var restaurants: [Businesses] = []
    // Outlets
    @IBOutlet weak var searchBarMap: UISearchBar!
    @IBOutlet weak var homeMapView: MKMapView!
    
    // Propeties
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?

    
    
    func fromYelp() {
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarMap.text
        request.region = homeMapView.region
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            print("------------ THREAD \(Thread.isMainThread)")
            
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
//                    let matchingItems = results.mapItems.compactMap({$0})
//                    self.matchingItems = matchingItems
                    // Getting data
                    guard let latitude = response?.boundingRegion.center.latitude else {return}
                    guard let longitude = response?.boundingRegion.center.longitude else {return}
                    
                    RestaurantInfoController.fetchRestaurantInfo(withSearchTerm: self.searchBarMap.text!, latitude: latitude, longitude: longitude) { (businesses) in
                        if let businesses = businesses {
                            self.restaurants = businesses
                            print("------------ THREAD \(Thread.isMainThread)")
                            
                        }
                        for objects in RestaurantInfoController.restaurants {
                            print("Name = \(objects.restaurantName ?? "No match")")
                            print("Phone = \(objects.restaurantPhone ?? "No Match")")
                            print(Thread.isMainThread)
                            print("Matching items = \(self.matchingItems.count)")
                            
                            guard let lat = objects.coordinate?.latitude,
                                let log =  objects.coordinate?.longitude else { return }
                        
                            let coordinate = self.getCordinate(latitude: lat, longitude: log)
                            
                            DispatchQueue.main.async {
//                                let annotation = MKPointAnnotation()
//                                annotation.coordinate = coordinate
//
//                                annotation.title = objects.restaurantName
//                                annotation.subtitle = objects.restaurantPhone
                                
                                let point = CustomAnnotation(coordinate: coordinate)
                                point.restaurantName = objects.restaurantName
                                point.restaurantImageUrlString = objects.restaurantImage
                                point.restaurantPrice = objects.restaurantPrice
                                point.restaurantDistance = objects.restaurantDistance
                                point.restaurantRating = objects.restaurantRating
                              
                                
                                self.homeMapView.addAnnotations([point])
                                print("------------ THREAD2 \(Thread.isMainThread) ------")
                                
                                //Zooming in on annotation
                                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                                let span = MKCoordinateSpanMake(0.03, 0.03)
                                let region = MKCoordinateRegionMake(coordinate, span)
                                self.homeMapView.setRegion(region, animated: true)
                            }
                        }
                    }
                    
                }
            }
        })
    }
    
    func getCordinate(latitude: Double, longitude: Double) -> CLLocationCoordinate2D {
        let lat = CLLocationDegrees(latitude)
        let log =  CLLocationDegrees(longitude)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: log)
        return coordinate
    }
    
    
//        func performSearch() {
//    
//            matchingItems.removeAll()
//            let request = MKLocalSearchRequest()
//            request.naturalLanguageQuery = searchBarMap.text
//            request.region = homeMapView.region
//    
//            let search = MKLocalSearch(request: request)
//    
//            search.start(completionHandler: {(response, error) in
//    
//                if let results = response {
//    
//                    if let err = error {
//                        print("Error occurred in search: \(err.localizedDescription)")
//                    } else if results.mapItems.count == 0 {
//                        print("No matches found")
//                    } else {
//                        print("Matches found")
//    
//                        // Remove current annotations on map
//                                        let annotations = self.homeMapView.annotations
//                                        self.homeMapView.removeAnnotations(annotations)
//    
//                                        // Getting data
//                                        guard let latitude = response?.boundingRegion.center.latitude else {return}
//                                        guard let longitude = response?.boundingRegion.center.longitude else {return}
//    
//                        for item in results.mapItems {
//                            print("Name = \(item.name ?? "No match")")
//                            print("Phone = \(item.phoneNumber ?? "No Match")")
//    
//                            self.matchingItems.append(item as MKMapItem)
//                            print("Matching items = \(self.matchingItems.count)")
//    
//                            let annotation = MKPointAnnotation()
//                            annotation.coordinate = item.placemark.coordinate
//                            annotation.title = item.name
//                            annotation.subtitle = item.phoneNumber
//
//                            self.homeMapView.addAnnotation(annotation)
//    
//                            //Zooming in on annotation
//                            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
//                            let span = MKCoordinateSpanMake(0.01, 0.01)
//                            let region = MKCoordinateRegionMake(coordinate, span)
//                            self.homeMapView.setRegion(region, animated: true)
//    
//                        }
//                    }
//                }
//            })
//        }
    //
    // Adding custom pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = self.homeMapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "pin")
        
//        let annotationView =  MKAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
//        annotationView.image = UIImage(named: "pin")
//        annotationView.canShowCallout = true
        
        //        joesFunction(annotationView)
        
        return annotationView
    }
    
    
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView) {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        // 2
        let customAnnotation = view.annotation as! CustomAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.restaurantName.text = customAnnotation.restaurantName
        calloutView.restaurantPrice.text = customAnnotation.restaurantPrice
        guard let restaurantDistance = (customAnnotation.restaurantDistance) else {return}
        let distanceInMiles = round((restaurantDistance/16.0934))/100
        calloutView.restaurantDistance.text = "\(distanceInMiles) miles away"
        if let rating = customAnnotation.restaurantRating{
            let intRating = Int(rating)
            guard let ratingEnum = Rating(rawValue: intRating) else {return}
            let image = getImageForRating(rating: ratingEnum)
            calloutView.ratingImageView.image = image
        }
        
        RestaurantInfoController.getRestaurantImage(imageStringURL: customAnnotation.restaurantImageUrlString) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                calloutView.restaurantImage.image = image
            }
        }
        
//        calloutView.starbucksName.text = starbucksAnnotation.name
//        calloutView.starbucksAddress.text = starbucksAnnotation.address
//        calloutView.starbucksPhone.text = starbucksAnnotation.phone
//        calloutView.starbucksImage.image = starbucksAnnotation.image
        // 3
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func getImageForRating(rating: Rating) -> UIImage?{
        switch rating {
        case .oneStar:
            return UIImage(named: "oneStar")
        case .twoStar:
            return UIImage(named: "twoStars")
        case .threeStar:
            return UIImage(named: "threeStars")
        case .fourStar:
            return UIImage(named: "fourStars")
        case .fiveStar:
            return UIImage(named: "fiveStars")
        }
    }
    
//
//    @objc func callPhoneNumber(sender: UIButton)
//    {
//        let v = sender.superview as! CustomCalloutView
//        if let url = URL(string: "telprompt://\(v.starbucksPhone.text!)"), UIApplication.shared.canOpenURL(url)
//        {
//            UIApplication.shared.openURL(url)
//        }
//    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
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
//        performSearch()
        fromYelp()
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
