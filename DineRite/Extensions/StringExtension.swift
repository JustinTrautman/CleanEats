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
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ&")
        return self.filter { okayChars.contains($0) }
    }
    
    var digitsOnly: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}

extension String {
    func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
    
    /// Returns a truncated string up to, but not including the ending character.
    func truncate(endingCharacter: String) -> String {
        var components = self.components(separatedBy: endingCharacter)
        return components[0]
    }
        /// Converts an Excel Serial Date to a human readable date
    func convertFromExcelDate() -> String {
        let serialValue = Int(self) ?? 0
        let secondsSince1970 = TimeInterval(serialValue - 25569) * 86400
        let gregorianDate = Date(timeIntervalSince1970: secondsSince1970)
        
        return Date().fullDate(date: gregorianDate)
    }
}
