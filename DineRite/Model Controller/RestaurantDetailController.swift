//
//  RestaurantDetailController.swift
//  CleanEats
//
//  Created by Joshua Danner on 7/18/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class RestaurantDetailController {
    
    static let authorizationKey = "Bearer VBD28yjGUwXP2DOqFu5UQIxZ_czZjgAbBijF-_2ch9SwdtsenIlG1cPbM0lQjYmWBmlpXNWku6aTS36pK3b6PwJqsJYW4NTmCbedCYvTm7uA3elgb6tXSBt-MIE-W3Yx"
    static let baseURL = URL(string: "https://api.yelp.com/v3/businesses")
    static var restaurantDetails: RestaurantDetails?
    static let shared = RestaurantDetailController()
    static let photos: [UIImage] = []
    
    static func fetchRestaurantDetailsWith(restaurantAlias: String, completion: @escaping ((RestaurantDetails)?) -> Void) {
        
        guard var url = baseURL else { completion(nil) ; return }
        url.appendPathComponent(restaurantAlias)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard let completeURL = components?.url else { completion(nil) ; return }
        
        print("📡📡📡📡 \(completeURL)📡📡📡📡")
        
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
                let restaurantDetails = try jsonDecoder.decode(RestaurantDetails.self, from: data)
                self.restaurantDetails = restaurantDetails
                completion(restaurantDetails)
            } catch let error {
                print("❌Error decoding restaurantDetail data; \(error) \(error.localizedDescription)")
                
            }
            }.resume()
    }
    
    static func fetchRestaurantPhoto(imageStringURL: String, completion: @escaping ((UIImage)?) -> Void) {
        guard let photosURL = URL(string: imageStringURL) else { completion(nil) ; return }
        
        URLSession.shared.dataTask(with: photosURL) { data, _, error in
            if let error = error {
                print("DataTask had issue getting photos from the network. Exiting with error: \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil) ; return }
            let photo = UIImage(data: data)
            completion(photo)
            
            }.resume()
    }
}
