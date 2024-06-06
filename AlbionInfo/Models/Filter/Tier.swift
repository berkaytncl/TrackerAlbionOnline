//
//  Tier.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 14.06.2024.
//

import Foundation

enum Tier: String, Filter {
    case all
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    
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
            return "T\(self.rawValue)"
        }
    }
}
