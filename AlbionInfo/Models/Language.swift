//
//  Language.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 16.07.2024.
//

import Foundation

enum Language: String, CaseIterable {
    case en
    case de
    case fr
    case ru
    case pl
    case es
    case ptBR = "pt-BR"
    case it
    case zhHans = "zh-Hans"
    case ko
    case ja
    case zhHant = "zh-Hant"
    case id
    case tr
    
    var displayName: String {
        switch self {
        case .en:
            return "English"
        case .de:
            return "Deutsch"
        case .fr:
            return "Français"
        case .ru:
            return "Русский"
        case .pl:
            return "Polski"
        case .es:
            return "Español"
        case .ptBR:
            return "Português (BR)"
        case .it:
            return "Italiano"
        case .zhHans:
            return "中文（简体）"
        case .ko:
            return "한국어"
        case .ja:
            return "日本語"
        case .zhHant:
            return "中文（繁體）"
        case .id:
            return "Bahasa Indonesia"
        case .tr:
            return "Türkçe"
        }
    }
    
    var languageIdentifier: String {
        switch self {
        case .ptBR: "pt_BR"
        case .zhHans: "zh_Hans"
        case .zhHant: "zh_Hant"
        default: self.rawValue
        }
    }
}
