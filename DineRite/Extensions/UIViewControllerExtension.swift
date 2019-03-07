//
//  UIViewControllerExtension.swift
//  DineRite
//
//  Created by Justin Trautman on 3/5/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Returns a 'toClassName' String for identifying segues
    class var segueIdentifier: String {
        return String(describing: "to\(self)")
    }
}
