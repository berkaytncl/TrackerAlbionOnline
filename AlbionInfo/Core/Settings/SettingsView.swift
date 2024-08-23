//
//  SettingsView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 11.06.2024.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @Binding var currentLocale: Locale
    @State private var selectedLanguage: Language
    
    private let urlString: String = "https://www.albion-online-data.com/"
    
    private let languageManager = LanguageManager.shared
    
    init(locale: Binding<Locale>) {
        selectedLanguage = languageManager.selectedLanguage
        _currentLocale = locale
    }
    
    var body: some View {
        ZStack {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack {
                header
                
                List {
                    Section(content: {
                        Picker(LocalizedKey.selectLanguage.localized, selection: $selectedLanguage) {
                            ForEach(Language.allCases, id: \.self) { language in
                                Text(language.displayName)
                                    .tag(language.rawValue)
                            }
                        }
                        .padding(8)
                    }, header: {
                        Text(.preferredLanguage)
                            .font(.callout)
                    })
                    .listRowBackground(Color.albionDarkBrown)
                    
                    Section(content: {
                        Text(.disclaimer)
                            .padding(8)
                        
                        Text(.pricesInfoSettings)
                            .padding(8)
                        
                        Text(.aodpTitle)
                            .foregroundStyle(.albionBrown)
                            .font(.title3)
                            .fontWeight(.bold)
                            .onTapGesture {
                                if let url = URL(string: urlString) {
                                    UIApplication.shared.open(url)
                                }
                            }
                            .padding(8)
                    }, header: {
                        Text(.info)
                            .font(.callout)
                    })
                    .listRowBackground(Color.albionDarkBrown)
                }
            }
            .listStyle(.plain)
        }
        .onReceive(Just(selectedLanguage), perform: { newValue in
            changeLanguage(to: newValue)
        })
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
        .tint(.albionBrown)
    }
    
    private var header: some View {
        HeaderView(
            title: .settings,
            isRootView: true
        )
    }
    
    private func changeLanguage(to language: Language) {
        guard let languageIdentifier = Locale.availableIdentifiers.first(where: { $0.contains(language.languageIdentifier) }) else {
            return
        }
        languageManager.selectedLanguage = language
        currentLocale = Locale(identifier: languageIdentifier)
    }
}

#Preview {
    SettingsView(locale: .constant(.current))
}
