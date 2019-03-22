//
//  UINavigationBarExtension.swift
//  DineRite
//
//  Created by Justin Trautman on 3/22/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

extension UINavigationBar {
    static func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 10.0)
    }
}
