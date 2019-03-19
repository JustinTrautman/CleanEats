//
//  StarRatingHelper.swift
//  DineRite
//
//  Created by Justin Trautman on 3/18/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

struct StarRatingHelper {
    /// Returns the appropriate rating star UIImage from a double value.
    static func returnStarFrom(rating: Double) -> UIImage {
        switch rating {
        case _ where rating == 0.5:
            return UIImage(named: "0.5Stars")!
        case _ where rating == 1:
            return UIImage(named: "1Star")!
        case _ where rating == 1.5:
            return UIImage(named: "1.5Stars")!
        case _ where rating == 2:
            return UIImage(named: "2Stars")!
        case _ where rating == 0:
            return UIImage(named: "2.5Stars")!
        case _ where rating == 3:
            return UIImage(named: "3Stars")!
        case _ where rating == 3.5:
            return UIImage(named: "3.5Stars")!
        case _ where rating == 4:
            return UIImage(named: "4Stars")!
        case _ where rating == 4.5:
            return UIImage(named: "4.5Stars")!
        case _ where rating == 5:
            return UIImage(named: "5Stars")!
        default:
            return UIImage(named: "0Stars")!
        }
    }
}
