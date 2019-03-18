//
//  ViolationDetailViewController+Handlers.swift
//  DineRite
//
//  Created by Justin Trautman on 3/6/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

extension ViolationDetailViewController {
    @objc func handlePhoneLabelTap(sender: UIView) {
        guard let numberToCall = phoneNumberLabel.text, !numberToCall.isEmpty else {
            return
        }
        OpenUrlHelper.call(phoneNumber: numberToCall)
    }
    
    @objc func handleAddressLabelTap(sender: UIView) {
        guard let addressToOpenInMaps = addressLabel.text, !addressToOpenInMaps.isEmpty,
        let destination = restaurantDetails?.restaurantName  else {
            return
        }
        OpenUrlHelper.openMapsWith(address: addressToOpenInMaps, destinationName: destination)
    }
    
    @objc func handleViolationCodeLabelTap(sender: UIView) {
        print("I will create a violation code database that will bring up more information when violation code is tapped")
    }
}
