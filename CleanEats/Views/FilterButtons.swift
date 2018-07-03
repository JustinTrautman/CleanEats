//
//  FilterButton.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/2/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation

protocol FilterButtonsDelegate: class {
    func typesController(_ controller: FilterButtons, didSelectTypes types: [String])
}

class FilterButtons {
    
    private let possibleTypesDictionary = ["restaurant","convenience_store","supermarket","meal_takeaway","meal_delivery"]
    private var sortedKeys: [String] {
        return possibleTypesDictionary.sorted()
    }
    
    var selectedTypes: [String] = []
    
}
