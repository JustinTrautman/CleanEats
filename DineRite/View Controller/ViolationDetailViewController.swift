//
//  ViolationDetailViewController.swift
//  DineRite
//
//  Created by Justin Trautman on 3/6/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

class ViolationDetailViewController: UIViewController {
    
    // MARK: Properties
    var healthInspection: HealthInspection?
    var restaurantDetails: Businesses?
    
    // UIKit Properties
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "Apollo Burger")
        return imageView
    }()
    
    let restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont(name: "system", size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoneLabelTap)))
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "system", size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddressLabelTap)))
        return label
    }()
    
    let violationTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 23)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.contentMode = .center
        return label
    }()
    
    let violationDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "system", size: 20)
        textView.isScrollEnabled = false
        return textView
    }()
    
    let violationCodeLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViolationCodeLabelTap)))
        return label
    }()
    
    let violationPointLabel = UILabel()
    let inspectionDateLabel = UILabel()
    
    // View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutViews()
        setViewProperties()
    }
    
    func layoutViews() {
        // Scroll View
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Content View
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // Restaurant Image View
        contentView.addSubview(restaurantImageView)
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
        restaurantImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        restaurantImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        restaurantImageView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        restaurantImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        // Restaurant Name Label
        contentView.addSubview(restaurantNameLabel)
        restaurantNameLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        restaurantNameLabel.leftAnchor.constraint(equalTo: restaurantImageView.rightAnchor, constant: 10).isActive = true
        restaurantNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        restaurantNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Phone Number Label
        contentView.addSubview(phoneNumberLabel)
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.topAnchor.constraint(equalTo: restaurantNameLabel.bottomAnchor, constant: 10).isActive = true
        phoneNumberLabel.leftAnchor.constraint(equalTo: restaurantImageView.rightAnchor, constant: 10).isActive = true
        phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        phoneNumberLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Address Label
        contentView.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: restaurantImageView.rightAnchor, constant: 10).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Violation Type Label
        contentView.addSubview(violationTypeLabel)
        violationTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        violationTypeLabel.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: 30).isActive = true
        violationTypeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        violationTypeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
        violationTypeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Violation Description Text View
        contentView.addSubview(violationDescriptionTextView)
        violationDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        violationDescriptionTextView.topAnchor.constraint(equalTo: violationTypeLabel.bottomAnchor, constant: 20).isActive = true
        violationDescriptionTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        violationDescriptionTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
        
        // Violation Code Label
        contentView.addSubview(violationCodeLabel)
        violationCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        violationCodeLabel.topAnchor.constraint(equalTo: violationDescriptionTextView.bottomAnchor, constant: 20).isActive = true
        violationCodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        violationCodeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
        violationCodeLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Violation Point Label
        contentView.addSubview(violationPointLabel)
        violationPointLabel.translatesAutoresizingMaskIntoConstraints = false
        violationPointLabel.topAnchor.constraint(equalTo: violationCodeLabel.bottomAnchor, constant: 20).isActive = true
        violationPointLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        violationPointLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
        violationPointLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Inspection Date Label
        contentView.addSubview(inspectionDateLabel)
        inspectionDateLabel.translatesAutoresizingMaskIntoConstraints = false
        inspectionDateLabel.topAnchor.constraint(equalTo: violationPointLabel.bottomAnchor, constant: 20).isActive = true
        inspectionDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        inspectionDateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
        inspectionDateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setViewProperties() {
        guard let inspection = healthInspection else {
            assertionFailure()
            return
        }
        
        let name = restaurantDetails?.restaurantName ?? "Unknown Restaurant"
        let phone = restaurantDetails?.restaurantPhone ?? "No phone number"
        let address = restaurantDetails?.location?.displayAddress.first ?? "Could not find address"
        let criticalScore = inspection.criticalViolation ?? 0
        let noncriticalScore = inspection.nonCriticalViolation ?? 0
        let violationDescription = inspection.violationTitle ?? "Additional violation info unavailable"
        let violationCode = inspection.violationCode ?? ""
        let inspectionDate = inspection.inspectionDate ?? "Inspection date unknown"
        let points = String(describing: inspection.weight ?? 0)

        DispatchQueue.main.async {
            self.restaurantNameLabel.text = name
            self.phoneNumberLabel.text = phone
            self.addressLabel.text = address
            self.violationDescriptionTextView.text = violationDescription

            let violationCodeText = NSMutableAttributedString()
            violationCodeText
                .normal("Violation code: ")
                .colored(violationCode, color: .red)

            self.violationCodeLabel.attributedText = violationCodeText
            self.inspectionDateLabel.text = "Inspection date: \(inspectionDate)"

            self.violationDescriptionTextView.heightAnchor.constraint(equalToConstant: self.violationDescriptionTextView.contentSize.height + 20).isActive = true

            let violationPointText = NSMutableAttributedString()
            violationPointText
                .normal("Violation points: ")

            switch points {
            case "6":
                violationPointText.colored(points, color: .red)
                self.violationPointLabel.attributedText = violationPointText
            case "3":
                violationPointText.colored(points, color: .orange)
                self.violationPointLabel.attributedText = violationPointText
            default:
                violationPointText.colored(points, color: .blue)
                self.violationPointLabel.attributedText = violationPointText
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
    }
}
