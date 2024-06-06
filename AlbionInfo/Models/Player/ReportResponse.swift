//
//  ReportResponse.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import Foundation

struct KDReportResponse: Codable, Hashable {
    let eventID, groupMemberCount, numberOfParticipants: Int
    let timeStamp: String
    let killer: KDData?
    let victim: KDData
    let killFame: Int
    
    enum CodingKeys: String, CodingKey {
        case eventID = "EventId"
        case groupMemberCount, numberOfParticipants
        case timeStamp = "TimeStamp"
        case killer = "Killer"
        case victim = "Victim"
        case killFame = "TotalVictimKillFame"
    }
    
    static func == (lhs: KDReportResponse, rhs: KDReportResponse) -> Bool {
        lhs.eventID == rhs.eventID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(eventID)
    }
}
 
extension KDReportResponse {
    static let mock: KDReportResponse = {
        KDReportResponse(
            eventID: 49734335,
            groupMemberCount: 1,
            numberOfParticipants: 1,
            timeStamp: "2024-07-08T17:53:58.449250500Z",
            killer: KDData(
                avgIP: 1238.61084,
                id: "qe4SW6aVQLqqnF7OOW_H2Q",
                name: "Matflow",
                guildName: "",
                allianceTag: "",
                equipment: Equipment(
                    mainHand: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T6_MAIN_MACE@1"
                    ),
                    offHand: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T6_OFF_SPIKEDSHIELD_MORGANA@1"
                    ),
                    head: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T6_HEAD_CLOTH_MORGANA@1"
                    ),
                    armor: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T6_ARMOR_LEATHER_MORGANA@1"
                    ),
                    shoes: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T5_SHOES_PLATE_ROYAL@1"
                    ),
                    bag: nil,
                    cape: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T4_CAPEITEM_UNDEAD@3"
                    ),
                    mount: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T4_MOUNT_GIANTSTAG"
                    ),
                    potion: EquipmentData(
                        count: 2,
                        quality: 0,
                        itemId: "T6_POTION_HEAL"
                    ),
                    food: EquipmentData(
                        count: 1,
                        quality: 0,
                        itemId: "T6_MEAL_STEW_FISH"
                    )
                ),
                loot: []
            ),
            victim: KDData(
                avgIP: 1076.66162,
                id: "3UwdHB3NQpuy6IamvM6gpw",
                name: "Ennuik",
                guildName: "",
                allianceTag: "",
                equipment: Equipment(
                    mainHand: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T4_2H_DUALSICKLE_UNDEAD@2"
                    ),
                    offHand: nil,
                    head: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T4_HEAD_LEATHER_MORGANA@2"
                    ),
                    armor: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T5_ARMOR_CLOTH_SET3@2"
                    ),
                    shoes: EquipmentData(
                        count: 1,
                        quality: 4,
                        itemId: "T5_SHOES_LEATHER_SET3@2"
                    ),
                    bag: EquipmentData(
                        count: 1,
                        quality: 2,
                        itemId: "T4_BAG"
                    ),
                    cape: EquipmentData(
                        count: 1,
                        quality: 1,
                        itemId: "T4_CAPEITEM_FW_CAERLEON"
                    ),
                    mount: EquipmentData(
                        count: 1,
                        quality: 2,
                        itemId: "T3_MOUNT_HORSE"
                    ),
                    potion: EquipmentData(
                        count: 1,
                        quality: 0,
                        itemId: "T7_POTION_REVIVE"
                    ),
                    food: EquipmentData(
                        count: 1,
                        quality: 0,
                        itemId: "T8_MEAL_STEW"
                    )
                ),
                loot: [
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil
                ]
            ),
            killFame: 42162
        )
    }()
}
