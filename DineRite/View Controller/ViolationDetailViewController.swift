//
//  ViolationDetailViewController.swift
//  DineRite
//
//  Created by Justin Trautman on 3/6/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit
import Kingfisher

class ViolationDetailViewController: UIViewController {
    
    // MARK: Properties
    var healthInspection: HealthInspection?
    var restaurantDetails: Businesses?
    
    // MARK: Outlets
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var violationTypeLabel: UILabel!
    @IBOutlet weak var violationDescriptionTextView: UITextView!
    @IBOutlet weak var violationDescriptionTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var violationCodeLabel: UILabel!
    @IBOutlet weak var violationPointLabel: UILabel!
    @IBOutlet weak var inspectionDateLabel: UILabel!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        violationCodeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViolationCodeLabelTap(sender:))))
        updateViews()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        DispatchQueue.main.async {
            self.violationDescriptionTextViewHeight.constant = self.violationDescriptionTextView.contentSize.height
        }
    }
    
    func updateViews() {
        guard let inspection = healthInspection,
            let restaurant = restaurantDetails else {
                assertionFailure()
                return
        }
        
        let name = restaurant.restaurantName ?? "Unknown Restaurant"
        let phone = restaurant.restaurantPhone == "" ? "No phone number" : restaurant.restaurantPhone
        let address = restaurant.location?.displayAddress.first ?? "Could not find address"
        let criticalScore = inspection.criticalViolation ?? 0
        let noncriticalScore = inspection.nonCriticalViolation ?? 0
        let violationDescription = inspection.violationTitle ?? "Additional violation info unavailable"
        let violationCode = inspection.violationCode ?? ""
        let inspectionDate = inspection.inspectionDate ?? "Inspection date unknown"
        let points = String(describing: inspection.weight ?? 0)
        
        DispatchQueue.main.async {
            self.restaurantNameLabel.text = name
            self.phoneNumberButton.setTitle(phone, for: .normal) 
            self.addressButton.setTitle(address, for: .normal)
            self.violationDescriptionTextView.text = violationDescription
            
            self.violationCodeLabel.text = violationCode
            self.inspectionDateLabel.text = inspectionDate
            
            switch points {
            case "6":
                self.violationPointLabel.textColor = .highestRiskViolation
                self.violationCodeLabel.textColor = .highestRiskViolation
                self.violationPointLabel.text = points
            case "3":
                self.violationPointLabel.textColor = .moderateRiskViolation
                self.violationCodeLabel.textColor = .moderateRiskViolation
                self.violationPointLabel.text = points
            default:
                self.violationPointLabel.textColor = .lowestRiskViolation
                self.violationCodeLabel.textColor = .lowestRiskViolation
                self.violationPointLabel.text = points
            }
            
            if criticalScore != 0 {
                self.violationTypeLabel.text = "Critical Violation"
                self.violationTypeLabel.textColor = .highestRiskViolation
            }
            
            if noncriticalScore != 0 {
                self.violationTypeLabel.text = "Noncritical Violation"
                self.violationTypeLabel.textColor = .moderateRiskViolation
            }
            
            if criticalScore == 0 && noncriticalScore == 0 {
                self.violationTypeLabel.text = "Other Violation"
                self.violationTypeLabel.textColor = .lowestRiskViolation
            }
        }
        
        if let restaurantImageUrl = URL(string: restaurant.restaurantImage) {
            let transition = ImageTransition.fade(0.2)
            
            DispatchQueue.main.async {
                self.restaurantImageView.kf.setImage(with: restaurantImageUrl, options: [.transition(transition)])
            }
        }
        updateViewConstraints()
    }
    
    // MARK: Actions
    @IBAction func addressButtonTapped(_ sender: Any) {
        guard let addressToOpenInMaps = addressButton.currentTitle, !addressToOpenInMaps.isEmpty,
            let destination = restaurantDetails?.restaurantName  else {
                return
        }
        OpenUrlHelper.openMapsWith(address: addressToOpenInMaps, destinationName: destination)
    }
    @IBAction func phoneButtonTapped(_ sender: Any) {
        guard let numberToCall = phoneNumberButton.currentTitle?.digitsOnly else {
            return
        }
        OpenUrlHelper.call(phoneNumber: numberToCall)
    }
}
