//
//  StringExtension.swift
//  CleanEats
//
//  Created by Justin Trautman on 8/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import Foundation

extension String {
    
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return self.filter {okayChars.contains($0) }
    }
}
