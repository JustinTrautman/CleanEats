//
//  OpenUrlHelper.swift
//  DineRite
//
//  Created by Justin Trautman on 3/4/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit
import SafariServices
//import CoreLocation
import MapKit

class OpenUrlHelper {
    
    static func format(phoneNumber: String) -> String? {
        let digitsOnly = phoneNumber.digitsOnly
        let length = digitsOnly.count
        let hasCountryCode = digitsOnly.hasPrefix("1")
        
        // Check if number is a supported length
        guard length == 7 || length == 10 || (length == 11 && hasCountryCode) else {
            return "Invalid phone number"
        }
        
        let hasAreaCode = (length >= 10)
        var sourceIndex = 0
        
        // Country code
        var countryCode = ""
        if hasCountryCode {
            countryCode = "1 "
            sourceIndex += 1
        }
        
        // Area code
        var areaCode = ""
        if hasAreaCode {
            let areaCodeLength = 3
            guard let areaCodeSubstring = digitsOnly.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
                return "Invalid phone number"
            }
            
            areaCode = String(format: "(%@) ", areaCodeSubstring)
            sourceIndex += areaCodeLength
        }
        
        // 3 digit sub prefix
        let prefixLength = 3
        guard let prefix = digitsOnly.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return "Invalid phone number"
        }
        
        sourceIndex += prefixLength
        
        // 4 digit suffix
        let suffixLength = 4
        guard let suffix = digitsOnly.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return "Invalid phone number"
        }
        
        return countryCode + areaCode + prefix + "-" + suffix
    }
    
    static func call(phoneNumber: String) {
        if let phoneUrl = URL(string: "telprompt://\(phoneNumber)") {
            UIApplication.shared.canOpenURL(phoneUrl)
            UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
        }
    }
    
    static func openWebsite(with url: String, on vc: UIViewController) {
        if let url = URL(string: url) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = vc as? SFSafariViewControllerDelegate
            
            DispatchQueue.main.async {
                vc.present(safariVC, animated: true)
            }
        }
    }
    
    static func openMapsWith(address: String, destinationName: String) {
        let geocoder = CLGeocoder()
        
        if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
            let url = URL(string: "comgooglemaps://?daddr=\(address)&directionsmode=driving")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Open in Apple Maps if Google Maps is not installed
            
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                if error != nil {
                    print(String(describing: error))
                    return
                    // TODO: Create user facing error
                }
                
                guard let placemarks = placemarks, let coordinates = placemarks.first?.location?.coordinate else {
                    return
                }
                
                let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02))
                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                let options = [
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
                mapItem.name = destinationName
                mapItem.openInMaps(launchOptions: options)
            }
        }
    }
}

