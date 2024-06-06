//
//  KDData.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import Foundation

struct KDData: Codable {
    let avgIP: Double
    let id: String
    let name: String
    let guildName, allianceTag: String
    let equipment: Equipment
    let loot: [EquipmentData?]
    
    enum CodingKeys: String, CodingKey {
        case avgIP = "AverageItemPower"
        case id = "Id"
        case name = "Name"
        case guildName = "GuildName"
        case allianceTag = "AllianceTag"
        case equipment = "Equipment"
        case loot = "Inventory"
    }
}
