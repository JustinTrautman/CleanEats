//
//  ArrayExtension.swift
//  CleanEats
//
//  Created by Justin Trautman on 8/19/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

/*
 
 This extension removes duplicates from arrays.
 Currently using this on the health data parser.
 
 */

import Foundation

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}
