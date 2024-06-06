//
//  PlayerResponse.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import Foundation

struct PlayerResponse: Codable {
    let players: [PlayerData]
}

struct PlayerData: Codable {
    let id, name: String
    let guildName, allianceName: String?
    let killFame, deathFame: Int
    let fameRatio: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case guildName = "GuildName"
        case allianceName = "AllianceName"
        case killFame = "KillFame"
        case deathFame = "DeathFame"
        case fameRatio = "FameRatio"
    }
}

extension PlayerData {
    static let mock: PlayerData = {
        .init(
            id: "qe4SW6aVQLqqnF7OOW_H2Q",
            name: "Matflow",
            guildName: "",
            allianceName: "",
            killFame: 6790663,
            deathFame: 5411082,
            fameRatio: 1.25
        )
    }()
}

struct PlayerServerData {
    let playerData: PlayerData
    let server: Server
}
