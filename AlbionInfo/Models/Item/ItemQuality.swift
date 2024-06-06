//
//  ItemQuality.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 15.07.2024.
//

import Foundation

enum ItemQuality: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    
    var localizedDescription: String {
        switch self {
        case .one:
            LocalizedKey.normalQuality.localized
        case .two:
            LocalizedKey.goodQuality.localized
        case .three:
            LocalizedKey.outstandingQuality.localized
        case .four:
            LocalizedKey.excellentQuality.localized
        case .five:
            LocalizedKey.masterpieceQuality.localized
        }
    }
}
