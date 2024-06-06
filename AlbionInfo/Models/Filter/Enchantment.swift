//
//  Enchantment.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 14.06.2024.
//

import Foundation

enum Enchantment: String, Filter {
    case all
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    
    var localizedDescription: String {
        switch self {
        case .all: LocalizedKey.all.localized
        default: self.rawValue
        }
    }
    
    var uniqueNameStr: String {
        switch self {
        case .all:
            return ""
        default:
            return "@\(self.rawValue)"
        }
    }
}
