//
//  ReportsType.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 17.07.2024.
//

import Foundation

enum ReportsType: String, Filter {
    case both, kills, deaths
    
    var localizedDescription: String {
        switch self {
        case .both:
            LocalizedKey.both.localized
        case .kills:
            LocalizedKey.kills.localized
        case .deaths:
            LocalizedKey.deaths.localized
        }
    }
}
