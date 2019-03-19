//
//  NSMutableAttributedStringExtension.swift
//  DineRite
//
//  Created by Justin Trautman on 3/6/19.
//  Copyright © 2019 Justin Trautman. All rights reserved.
//

import UIKit
extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont(name: "AmericanTypewriter-CondensedBold", size: 17)!]
        let boldText = NSMutableAttributedString(string: text, attributes: attributes)
        append(boldText)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
    
    @discardableResult func colored(_ text: String, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [.foregroundColor: color, .font: UIFont.systemFont(ofSize: 15)]
        let coloredText = NSMutableAttributedString(string: text, attributes: attributes)
        append(coloredText)
        
        return self
    }
}
