//
//  OrderType.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 17.07.2024.
//

import Foundation

enum OrderType: String, Filter {
    case ascending, descending
    
    var localizedDescription: String {
        switch self {
        case .ascending:
            LocalizedKey.ascending.localized
        case .descending:
            LocalizedKey.descending.localized
        }
    }
}
