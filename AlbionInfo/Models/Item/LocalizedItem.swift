//
//  LocalizedItem.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import Foundation

struct LocalizedItemResponse: Codable {
    let localizedNames, localizedDescriptions: Localized?
    let itemId, uniqueName: String
    
    enum CodingKeys: String, CodingKey {
        case localizedNames = "LocalizedNames"
        case localizedDescriptions = "LocalizedDescriptions"
        case itemId = "Index"
        case uniqueName = "UniqueName"
    }
}

struct LocalizedItem {
    let localizedNames, localizedDescriptions: Localized
    let itemId, uniqueName: String
    var filteredFormDefaultLanguage: Bool = false
}

extension LocalizedItem {
    static let mock: LocalizedItem = {
        LocalizedItem(
            localizedNames: Localized(
                enUs: "Elder's Chillhowl",
                deDe: "Frostschrei des Ältesten",
                frFr: "Hurlegivre du sage",
                ruRu: "Леденящий вой (старейшина)",
                plPl: "Ryk Mrozu Starszego",
                esEs: "Grito gélido del anciano",
                ptBr: "Uivo Frio do Ancião",
                itIt: "Ululato gelido dell'anziano",
                zhCn: "禅师级冰嚎法杖",
                koKr: "장로의 칠하울",
                jaJp: "장로의 칠하울",
                zhTw: "禪師級冰嘯法杖",
                idId: "Raungdingin Tetua",
                trTr: "Yüce Soğuk Uğultusu"
            ),
            localizedDescriptions: Localized(
                enUs: "Equipment Item",
                deDe: "Ausrüstungsgegenstand",
                frFr: "Pièce d'équipement",
                ruRu: "Снаряжение",
                plPl: "Przedmiot do wyposażenia",
                esEs: "Objeto de equipo",
                ptBr: "Item de Equipamento",
                itIt: "Oggetto d'equipaggiamento",
                zhCn: "装备物品",
                koKr: "装备物品",
                jaJp: "装備アイテム",
                zhTw: "裝備物品",
                idId: "Item Perlengkapan",
                trTr: "Ekipman Eşyası"
            ),
            itemId: "6889",
            uniqueName: "T8_MAIN_FROSTSTAFF_AVALON@4",
            filteredFormDefaultLanguage: false
        )
    }()
}
