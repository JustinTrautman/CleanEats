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
    static let baseURL = URL(string: "https://api.yelp.com/v3/businesses")
    static var reviews: [Reviews] = []
    
    static func fetchRestaurantReview(withID: String, completion: @escaping([Reviews]?) -> Void) {
        
        guard var url = baseURL else { completion(nil) ; return }
        url.appendPathComponent(withID)
        url.appendPathComponent("reviews")
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard let completeURL = components?.url else { completion(nil) ; return }
        
        var request = URLRequest(url: completeURL)
        request.addValue(Constants.yelpAuthorizationKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("DataTask had an issue reaching the network. Exiting with error: \(error) \(error.localizedDescription)")
                completion(nil)
                return
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
