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
    
    /// Returns a string from a string date in 'MM/dd/yyyy' format.
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // This format is input formatted .
        
        guard let formatDate = dateFormatter.date(from: self) else {
            return "unknown date"
        }
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: formatDate)
    }
    
    /// Returns a string in 12 hour time format from a military time.
    func convertFromMilitaryTime() -> String { // TODO: Refactor from brute force.
        switch self {
        case "0100":
            return "1:00 a.m"
        case "0200":
            return "2:00 a.m"
        case "0300":
            return "3:00 a.m"
        case "0400":
            return "4:00 a.m"
        case "0500":
            return "5:00 a.m"
        case "0600":
            return "6:00 a.m"
        case "0700":
            return "7:00 a.m"
        case "0800":
            return "8:00 a.m"
        case "0900":
            return "9:00 a.m"
        case "1000":
            return "10:00 a.m"
        case "1100":
            return "11:00 a.m"
        case "1200":
            return "12:00 p.m"
        case "1300":
            return "1:00 p.m"
        case "1400":
            return "2:00 p.m"
        case "1500":
            return "3:00 p.m"
        case "1600":
            return "4:00 p.m"
        case "1700":
            return "5:00 p.m"
        case "1800":
            return "6:00 p.m"
        case "1900":
            return "7:00 p.m"
        case "2000":
            return "8:00 p.m"
        case "2100":
            return "9:00 p.m"
        case "2200":
            return "10:00 p.m"
        case "2300":
            return "11:00 p.m"
        default:
            return "12:00 a.m"
        }
    }
}
