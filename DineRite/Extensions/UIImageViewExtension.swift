//
//  UIImageViewExtension.swift
//  DineRite
//
//  Created by Justin Trautman on 3/18/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundImage() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}
