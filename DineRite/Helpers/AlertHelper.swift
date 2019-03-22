//
//  AlertHelper.swift
//  DineRite
//
//  Created by Justin Trautman on 3/22/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit

struct AlertHelper {
    /// A customizable alert with a title and a message. 1 Default "OK" action.
    static func showCustomAlert(on vc: UIViewController, title: String, message: String) {
        let customAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        customAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(customAlert, animated: true)
        }
    }
    
    static func showErrorRemovingFavoriteAlert(vc: UIViewController) {
        showCustomAlert(on: vc, title: "Error", message: "There was a problem removing that favorite from your list of favorites. Please try again.")
    }
    
    static func showInspectionInformationalAlert(vc: UIViewController) {
        showCustomAlert(on: vc, title: "Violation Categorization", message: "Critical Violations: \n Violations of critical food handling practices and conditions, or existence of an environmental health hazard. \n\n Non-Critical Violations: \n Low risk violations include proper storage of utensils and linens, adequate lighting, lack of refrigerator thermometers, and soiled food contact surfaces. \n\n Violation points may be: \n 1(lowest risk violations), \n 3(moderate risk violations), \n or 6 points(highest risk violations).")
    }
    
    static func showNoSearchResultsAlert(vc: UIViewController, searchTerm: String) {
        showCustomAlert(on: vc, title: "No Search Results", message: "We couldn't find any search results for \(searchTerm). Please try again.")
    }
    
    static func showNoSearchTextAlert(vc: UIViewController) {
        showCustomAlert(on: vc, title: "No Seach Entry", message: "The search bar cannot be left blank.")
    }
    
    static func showMapPopulationErrorAlert(vc: UIViewController) {
        showCustomAlert(on: vc, title: "Error Fetching Restaurants", message: "A temporary connection issue prevented us from fetching nearby restaurants. Please try again.")
    }
}
