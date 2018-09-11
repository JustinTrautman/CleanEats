//
//  RestaurantReviewController.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/10/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation
import UIKit

class RestaurantReviewController {
    static let shared = RestaurantReviewController()
    let authorizationKey = "Bearer VBD28yjGUwXP2DOqFu5UQIxZ_czZjgAbBijF-_2ch9SwdtsenIlG1cPbM0lQjYmWBmlpXNWku6aTS36pK3b6PwJqsJYW4NTmCbedCYvTm7uA3elgb6tXSBt-MIE-W3Yx"
    
    let baseURL = URL(string: "https://api.yelp.com/v3/businesses")
    var reviews: [Reviews] = []
    
    func fetchRestaurantReview(withID: String, completion: @escaping([Reviews]?) -> Void) {
        
        guard var url = baseURL else { completion(nil) ; return }
        url.appendPathComponent(withID)
        url.appendPathComponent("reviews")
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard let completeURL = components?.url else { completion(nil) ; return }
        
        var request = URLRequest(url: completeURL)
        request.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("DataTask had an issue reaching the network. Exiting with error: \(error) \(error.localizedDescription)")
                completion(nil)
            }
            guard let data = data else { completion(nil) ; return }
            let jsonDecoder = JSONDecoder()
            
            do {
                let reviews = try jsonDecoder.decode(TopReviewData.self, from: data).reviews
                self.reviews = reviews
                completion(reviews)
                
            } catch let error {
                print("Error decoding restaurant data: \(error) \(error.localizedDescription)")
            }
            }.resume()
    }
    
    static func getReviewerImage(imageStringURL: String, completion: @escaping ((UIImage?)) -> Void) {
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
