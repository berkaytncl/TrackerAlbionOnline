//
//  TabBarItem.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 19.07.2024.
//

import Foundation

enum TabBarItem: String {
    case player, items, gold, settings
    
    var iconName: String {
        switch self {
        case .player: "person"
        case .items: "square.grid.2x2"
        case .gold: "crown"
        case .settings: "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .player: LocalizedKey.player.localized
        case .items: LocalizedKey.items.localized
        case .gold: LocalizedKey.gold.localized
        case .settings: LocalizedKey.settings.localized
        }
    }
}
