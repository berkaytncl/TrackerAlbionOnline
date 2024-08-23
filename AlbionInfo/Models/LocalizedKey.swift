//
//  LocalizedKey.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 16.07.2024.
//

import Foundation

enum LocalizedKey: String, CaseIterable {
    case inventoryTitle = "inventory_title"
    case reportsFound = "reports_found"
    case aodpTitle = "aodp_title"
    case buy
    case city
    case enchantment = "enchantment"
    case equipments = "equipments"
    case excellentQuality = "excellent_quality"
    case gold
    case goldPrice = "gold_price"
    case goodQuality = "good_quality"
    case info
    case inventoryEmpty = "inventory_empty"
    case itemPrice = "item_price"
    case items
    case masterpieceQuality = "masterpiece_quality"
    case noKillDeathReport = "no_kill_death_report"
    case normalQuality = "normal_quality"
    case outstandingQuality = "outstanding_quality"
    case player
    case playerSettings = "player_settings"
    case playersInfo = "players_info"
    case preferredLanguage = "preferred_language"
    case pricesInfoSettings = "prices_info_settings"
    case reportDetail = "report_detail"
    case reportsType = "reports_type"
    case searchPlaceholderPlayer = "search_placeholder_player"
    case searchPlaceholderItem = "search_placeholder_item"
    case searchPlayer = "search_player"
    case selectLanguage = "select_language"
    case sell
    case server
    case settings
    case sortBy = "sort_by"
    case sortOrder = "sort_order"
    case disclaimer = "disclaimer"
    case tierLabel = "tier_label"
    case trackedPlayers = "tracked_players"
    case noPlayerMatchingFound = "no_player_matching_found"
    case west
    case east
    case europe
    case both
    case kills
    case deaths
    case time
    case fame
    case ascending
    case descending
    case all
    case currentGoldPrice = "current_gold_price"

    var localized: String {
        LanguageManager.shared.localizedString(for: self.rawValue)
    }
    
    func localized(with arguments: CVarArg...) -> String {
        LanguageManager.shared.localizedString(for: self.rawValue, with: arguments)
    }
}
