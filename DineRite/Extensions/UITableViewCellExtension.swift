//
//  UITableViewCellExtension.swift
//  DineRite
//
//  Created by Justin Trautman on 3/5/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// Returns a String representation of this class
    class var identifier: String {
        return String(describing: self)
    }
}
