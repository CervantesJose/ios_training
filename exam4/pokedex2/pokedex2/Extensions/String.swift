//
//  String.swift
//  pokedex2
//
//  Created by Consultant on 6/23/22.
//

import UIKit

extension String {
    var cleaned: String {
        let e = replacingOccurrences(of: "é", with: "e")
        let dash = e.replacingOccurrences(of: "-", with: " ").capitalized
        return dash
    }
    
    func lineHeight(_ height: CGFloat) -> NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = height
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }

    func foundMatch(for string: String) -> Bool {
        (cleaned as NSString).range(of: string, options: .caseInsensitive).location != NSNotFound
    }
}
