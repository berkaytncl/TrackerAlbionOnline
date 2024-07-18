//
//  SettingsView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 11.06.2024.
//

import SwiftUI
import SwiftfulRouting
import Combine

struct SettingsView: View {
    @State private var currentLocale: Locale = .current
    @State private var selectedLanguage: Language
    
    private let urlString: String = "https://www.albion-online-data.com/"
    
    private let router: AnyRouter
    private let languageManager = LanguageManager.shared
    
    init(router: AnyRouter) {
        self.router = router
        selectedLanguage = languageManager.selectedLanguage
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
                            .foregroundStyle(.blue)
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
        .environment(\.locale, currentLocale)
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
        .tint(.albionBrown)
    }
    
    private var header: some View {
        HeaderView(
            title: LocalizedKey.settings.localized,
            leftImageName: "arrow.uturn.left",
            leftBarItemPressed: router.dismissScreen
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
    RouterView { router in
        SettingsView(router: router)
    }
}
