//
//  RestaurantProfileViewController+Handlers.swift
//  DineRite
//
//  Created by Justin Trautman on 3/17/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

extension RestaurantProfileViewController {
    @objc func handleSegmentSelectionChange(_ sender: UISegmentedControl) {
        updateContainerView()
    }
}
