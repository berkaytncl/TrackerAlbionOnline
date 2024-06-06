//
//  SortBy.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 17.07.2024.
//

import Foundation

enum SortBy: String, Filter {
    case time, fame
    
    var localizedDescription: String {
        switch self {
        case .time:
            LocalizedKey.time.localized
        case .fame:
            LocalizedKey.fame.localized
        }
    }
}
