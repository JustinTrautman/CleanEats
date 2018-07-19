//
//  RestaurantDetailController.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/18/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation

class RestaurantDetailController {
    
    static let authorizationKey = "Bearer VBD28yjGUwXP2DOqFu5UQIxZ_czZjgAbBijF-_2ch9SwdtsenIlG1cPbM0lQjYmWBmlpXNWku6aTS36pK3b6PwJqsJYW4NTmCbedCYvTm7uA3elgb6tXSBt-MIE-W3Yx"
    static let baseURL = URL(string: "https://api.yelp.com/v3/businesses")
    static var restaurants: [RestaurantDetails] = []
    static let shared = RestaurantDetailController()
    
    static func fetchRestaurantDetailsWith(restaurantID: String, completion: @escaping (([RestaurantDetails])?) -> Void) {
        
        guard var url = baseURL else { completion(nil) ; return }
        url.appendPathComponent(restaurantID)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        
        guard let completeURL = components?.url else { completion(nil) ; return }
        
        print(completeURL)
        
        var request = URLRequest(url: completeURL)
        request.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("DataTask had an issue reaching the network. Exiting with error: \(error) \(error.localizedDescription)")
                completion(nil) ;
                return
            }
            
            guard let data = data else { completion(nil) ; return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let restaurantDetails = try jsonDecoder.decode(TopData.self, from: data).restaurants
                self.restaurants = restaurantDetails
                completion(restaurantDetails)
            } catch let error {
                print("Error decoding restaurant data: \(error) \(error.localizedDescription)")
            }
        }.resume()
    }
}
