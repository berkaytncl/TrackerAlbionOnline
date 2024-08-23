//
//  LanguageManager.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 16.07.2024.
//

import Foundation
import Combine

final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    private static let defaultsKey = "selected_language"
    
    @Published var selectedLanguage: Language {
        didSet {
            UserDefaults.standard.set(selectedLanguage.rawValue, forKey: LanguageManager.defaultsKey)
        }
    }
    
    private init() {
        selectedLanguage = Language(rawValue: UserDefaults.standard.string(forKey: Self.defaultsKey) ?? "") ??
        Language(rawValue: Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? "") ??
        Language(rawValue: Locale.preferredLanguages.first ?? "") ??
        Language.en
    }
    
    func localizedString(for key: String, comment: String = "") -> String {
        guard let path = Bundle.main.path(forResource: selectedLanguage.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: comment)
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, comment: comment)
    }
    
    func localizedString(for key: String, with arguments: [CVarArg], comment: String = "") -> String {
        guard let path = Bundle.main.path(forResource: selectedLanguage.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            let format = NSLocalizedString(key, comment: comment)
            return String(format: format, arguments: arguments)
        }
        let format = NSLocalizedString(key, tableName: nil, bundle: bundle, comment: comment)
        return String(format: format, arguments: arguments)
    }
}
