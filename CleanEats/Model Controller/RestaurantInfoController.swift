//
//  RestaurantInfoController.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import CoreLocation


enum SearchType: String {
    
    case SearchbarText = ""
    case filterButton
}

class RestaurantInfoController {
    
    static let authorizationKey = "Bearer VBD28yjGUwXP2DOqFu5UQIxZ_czZjgAbBijF-_2ch9SwdtsenIlG1cPbM0lQjYmWBmlpXNWku6aTS36pK3b6PwJqsJYW4NTmCbedCYvTm7uA3elgb6tXSBt-MIE-W3Yx"
    static let baseURL = URL(string: "https://api.yelp.com/v3/businesses/search")
    static var restaurants: [Businesses] = []
    
    
    static func fetchRestaurantInfo(withSearchTerm: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (([Businesses])?) -> Void) {

        guard let url = baseURL else { completion(nil) ; return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let termQuery = URLQueryItem(name: "term", value: "\(withSearchTerm)")
        let latitudeQuery = URLQueryItem(name: "latitude", value: "\(latitude)")
        let longitudeQuery = URLQueryItem(name: "longitude", value: "\(longitude)")
        let categoryQuery = URLQueryItem(name: "category", value: "restaurants + grocery")
        let radiusQuery = URLQueryItem(name: "radius", value: "3000")
        let sortByQuery = URLQueryItem(name: "sort_by", value: "distance")
        let limitQuery = URLQueryItem(name: "limit", value: "10")
        
        let queryArray = [termQuery, latitudeQuery, longitudeQuery, categoryQuery, radiusQuery, sortByQuery, limitQuery]
        components?.queryItems = queryArray
        
        guard let completeURL = components?.url else { completion(nil) ; return }
        
        print(completeURL)
        
        var request = URLRequest(url: completeURL)
        request.addValue(authorizationKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("DataTask had an issue reaching the network. Exiting with error: \(error) \(error.localizedDescription)")
                 completion(nil) ; return
            }
            
            guard let data = data else { completion(nil) ; return }
            let jsonDecoder = JSONDecoder()
            
            do {
                let restaurants = try jsonDecoder.decode(TopLevelData.self, from: data).businesses
                self.restaurants = restaurants
                completion(restaurants)

            } catch let error {
                print("Error decoding restaurant data: \(error) \(error.localizedDescription)")
                
            }
        }.resume()
    }
    
    static func getRestaurantImage(imageStringURL: String, completion: @escaping ((UIImage?)) -> Void) {
        guard let url = URL(string: imageStringURL) else { completion(nil) ; return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("DataTask had an issue getting an image from the network. Exiting with error: \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
                
                guard let data = data else { completion(nil) ; return }
                let image = UIImage(data: data)
                completion(image)
        }.resume()
    }
}
