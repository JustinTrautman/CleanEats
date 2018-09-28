//
//  StoreReviewHelper.swift
//  DineRite
//
//  Created by Justin Trautman on 9/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation
import StoreKit

struct StoreFeedbackHelper {
    static func incrementAppOpenedCount() {
        let currentCount = UserDefaults.standard.integer(forKey: "launchCount")
        
        // Increment count by one when function is called
        UserDefaults.standard.set(currentCount + 1, forKey: "launchCount")
        
        // Save count
        UserDefaults.standard.synchronize()
        print("🔥🔥🔥🔥App has been opened \(currentCount + 1) times!🔥🔥🔥🔥")
    }
    
    static func askForReview() {
        let appOpenedCount = UserDefaults.standard.integer(forKey: "launchCount")
        
        switch appOpenedCount {
        case 5, 20, 50:
            StoreFeedbackHelper().requestReview()
        default:
            print("App has been opened \(appOpenedCount) times!")
            break
        }
    }
    
    
    func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
}
