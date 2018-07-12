//
//  RestaurantInfoController.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/9/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation
import CoreLocation

enum SearchType: String {
    
    case SearchbarText = ""
    case filterButton
}

class RestaurantInfoController {
    
    static let authorizationKey = "Bearer VBD28yjGUwXP2DOqFu5UQIxZ_czZjgAbBijF-_2ch9SwdtsenIlG1cPbM0lQjYmWBmlpXNWku6aTS36pK3b6PwJqsJYW4NTmCbedCYvTm7uA3elgb6tXSBt-MIE-W3Yx"
    
    static let baseURL = URL(string: "https://api.yelp.com/v3/businesses/search")
    
    static var restaurants: [Businesses] = []
    
    static var sharedRestaurant = RestaurantInfoController()
    
    static func fetchRestaurantInfo(with searchTerm: String, andLocation: String, completion: @escaping ((Businesses)?) -> Void) {
        
        guard let url = baseURL else { completion(nil) ; return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let termQuery = URLQueryItem(name: "term", value: "\(searchTerm)")
        let locationQuery = URLQueryItem(name: "location", value: "\(andLocation)")
        
        let queryArray = [termQuery, locationQuery]
        components?.queryItems = queryArray
        
        guard let completeURL = components?.url else { completion(nil) ; return }
        
        print(completeURL)
        
        var request = URLRequest(url: completeURL)
        request.addValue(authorizationKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("DataTask had an issue reaching the network. Exiting with error: \(error) \(error.localizedDescription)")
            }
            
            guard let data = data else { completion(nil) ; return }
            let jsonDecoder = JSONDecoder()
            
            do {
                let restaurants = try jsonDecoder.decode(TopLevelData.self, from: data).businesses
                self.restaurants = restaurants
                
            } catch let error {
                print("Error decoding restaurant data: \(error) \(error.localizedDescription)")
            }
        }.resume()
    }
}
