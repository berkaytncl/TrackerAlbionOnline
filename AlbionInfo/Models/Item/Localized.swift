//
//  Localized.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 13.06.2024.
//

import Foundation

struct Localized: Codable {
    let enUs, deDe, frFr, ruRu: String
    let plPl, esEs, ptBr, itIt: String
    let zhCn, koKr, jaJp, zhTw: String
    let idId, trTr: String
    
    enum CodingKeys: String, CodingKey {
        case enUs = "EN-US" // english
        case deDe = "DE-DE" // german
        case frFr = "FR-FR" // french
        case ruRu = "RU-RU" // russian
        case plPl = "PL-PL" // polish
        case esEs = "ES-ES" // spanish
        case ptBr = "PT-BR" // portuguese (brazil)
        case itIt = "IT-IT" // italian
        case zhCn = "ZH-CN" // chinese (simplified)
        case koKr = "KO-KR" // korean
        case jaJp = "JA-JP" // japanese
        case zhTw = "ZH-TW" // chinese (traditional)
        case idId = "ID-ID" // indonesian
        case trTr = "TR-TR" // turkish
    }
    
    func getLocalizedText(for language: Language) -> String {
        switch language {
        case .en: enUs
        case .de: deDe
        case .fr: frFr
        case .ru: ruRu
        case .pl: plPl
        case .es: esEs
        case .ptBR: ptBr
        case .it: itIt
        case .zhHans: zhCn
        case .ko: koKr
        case .ja: jaJp
        case .zhHant: zhTw
        case .id: idId
        case .tr: trTr
        }
    }
}
