//
//  Int+Extensions.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.07.2024.
//

import Foundation

extension Int {
    var abbreviated: String {
        let number = Double(self)
        let thousand = number / 1_000
        let million = number / 1_000_000
        let billion = number / 1_000_000_000
        
        if billion >= 1 {
            return "\(round(billion * 10) / 10)B"
        } else if million >= 1 {
            return "\(round(million * 10) / 10)M"
        } else if thousand >= 1 {
            return "\(round(thousand * 10) / 10)K"
        } else {
            return "\(self)"
        }
    }
}
