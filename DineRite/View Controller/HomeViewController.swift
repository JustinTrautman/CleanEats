import UIKit
import MapKit
import Kingfisher

@IBDesignable
class CustomSearchBar: UISearchBar {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            return layer.cornerRadius = cornerRadius
        }
    }
}

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: Properties
    var matchingRestaurants: [MKMapItem] = [MKMapItem]()
    var restaurants: [Businesses] = []
    var selectedAnnotation: MKPointAnnotation?
    var mapAddress: String?
    
    // MARK: Outlets
    @IBOutlet weak private var mapSearchBar: CustomSearchBar!
    @IBOutlet weak private var homeMapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    var selectedRestaurant: Businesses?
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeMapView.delegate = self
        mapSearchBar.delegate = self
        locationManager.delegate = self
        homeMapView.showsUserLocation = true
        mapSearchBar.backgroundImage = UIImage()
        mapSearchBar.layer.cornerRadius = mapSearchBar.bounds.height / 2
        mapSearchBar.clipsToBounds = true
        mapSearchBar.layer.shadowColor = UIColor.darkGray.cgColor
        mapSearchBar.layer.shadowOffset = CGSize(width: 1, height: 1)
        mapSearchBar.layer.shadowRadius = 2
        mapSearchBar.layer.shadowOpacity = 0.65
        
        let scale = MKScaleView(mapView: homeMapView)
        scale.scaleVisibility = .visible
        view.addSubview(scale)
        
        addDineRiteLogoToNavigationBar()
        configureLocationServices()
    }
    
    func fetchRestaurantInfoFromYelp() {
        matchingRestaurants.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = mapSearchBar.text
        request.region = homeMapView.region
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: { [unowned self] (response, error) in
            guard let searchText = self.mapSearchBar.text, !searchText.isEmpty else {
                AlertHelper.showNoSearchTextAlert(vc: self)
                return
            }
            
            if error != nil || response == nil {
                AlertHelper.showNoSearchResultsAlert(vc: self, searchTerm: searchText)
                return
            }
            
            // Remove any active annotations before fetching new ones.
            let annotations = self.homeMapView.annotations
            self.homeMapView.removeAnnotations(annotations)
            
            guard let latitude = response?.boundingRegion.center.latitude,
                let longitude = response?.boundingRegion.center.longitude else { return }
            
            RestaurantInfoController.fetchRestaurantInfo(withSearchTerm: searchText, latitude: latitude, longitude: longitude) { (businesses) in
                if let businesses = businesses {
                    self.restaurants = businesses
                }
                
                for restaurant in RestaurantInfoController.restaurants {
                    guard let restaurantLatitude = restaurant.coordinate?.latitude,
                        let restaurantLongitude =  restaurant.coordinate?.longitude else { return }
                    
                    let restaurantCoordinates = CLLocationCoordinate2D(latitude: restaurantLatitude, longitude: restaurantLongitude)
                    
                    DispatchQueue.main.async {
                        let point = CustomAnnotation(coordinate: restaurantCoordinates, restaurant: restaurant)
                        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                        let region = MKCoordinateRegion(center: coordinate, span: span)
                        
                        self.homeMapView.addAnnotations([point])
                        self.homeMapView.setRegion(region, animated: true)
                    }
                }
            }
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchRestaurantInfoFromYelp()
        mapSearchBar.resignFirstResponder()
        zoomToLatestLocation(with: currentCoordinate!) // TODO: Change the way coordinates are fetched upon launch and safely unwrap.
    }
    
    func addDineRiteLogoToNavigationBar() {
        let logo = UIImage(named: "DineRiteNew")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func beginLocationUpdates(locationManager: CLLocationManager) {
        homeMapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        homeMapView.setRegion(zoomRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? MKPointAnnotation
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantProfile" {
            guard let detailVC = segue.destination as? RestaurantProfileViewController else { return }
            detailVC.mapAddress = mapAddress
            detailVC.restaurants = self.selectedRestaurant
        }
    }
}

// MARK: Map Kit Delegate
extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = self.homeMapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil {
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "pin")
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        
        let customAnnotation = view.annotation as! CustomAnnotation
        let views = Bundle.main.loadNibNamed("CalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CalloutView
        
        calloutView.restaurant = customAnnotation.restaurant
        calloutView.delegate = self
        
        // Returns the restaurant's street name capitalized. Required to match database naming conventions.
        let address = customAnnotation.restaurant.location?.displayAddress[0].truncate(endingCharacter: ",")
        mapAddress = address?.uppercased()
        
        if let imageUrl = URL(string: customAnnotation.restaurantImageUrlString) {
            let imageTransition = ImageTransition.fade(0.2)
            
            DispatchQueue.main.async {
                calloutView.restaurantImage.kf.indicatorType = .activity
                calloutView.restaurantImage.kf.setImage(with: imageUrl, options: [.transition(imageTransition)])
            }
        }
        
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height * 0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self) {
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}

// MARK: Core Location Manager Delegate
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        
        currentCoordinate = latestLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
    
    func configureLocationServices() {
        let status = CLLocationManager.authorizationStatus()
        
        if status == .restricted ||
            status == .denied ||
            status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    func showNoResultsAlert() {
        guard let searchedTerm = mapSearchBar.text else { return }
        AlertHelper.showNoSearchResultsAlert(vc: self, searchTerm: searchedTerm)
    }
}

extension HomeViewController: CalloutViewDelegate {
    func calloutViewTapped(restaurant: Businesses, sender: CalloutView) {
        self.selectedRestaurant = restaurant
        self.performSegue(withIdentifier: "restaurantProfile", sender: sender)
    }
}
