//
//  RootView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 6.06.2024.
//

import SwiftUI
import SwiftfulRouting
import Combine

struct RootView: View {
    @State private var currentLocale: Locale = .current
    @State private var tabSelection: TabBarItem
    
    init() {
        let tabSelection = UserDefaults.standard.tabSelection
        self.tabSelection = tabSelection == .settings ? .player : tabSelection
    }
    
    var body: some View {
        ZStack {
            Color.albionDarkBrown.ignoresSafeArea()
            
            tabBarSection
                .id(currentLocale.identifier)
        }
    }
    
    @MainActor
    private var tabBarSection: some View {
        TabView(selection: $tabSelection) {
            RouterView { router in
                KDInfoView(
                    viewModel: KDInfoViewModel(
                        router: router,
                        kdReportDataService: KDReportDataService(),
                        favoritePlayerDataManager: FavoritePlayerDataManager.shared
                    )
                )
            }
            .tabItem {
                Label(
                    TabBarItem.player.title,
                    systemImage: TabBarItem.player.iconName
                )
            }
            .tag(TabBarItem.player)
            
            RouterView { router in
                ItemsView(
                    viewModel: ItemsViewModel(
                        router: router,
                        itemDataService: ItemsDataService.shared,
                        languageManager: LanguageManager.shared,
                        favoriteItemDataManager: FavoriteItemsDataManager.shared
                    )
                )
            }
            .tabItem {
                Label(
                    TabBarItem.items.title,
                    systemImage: TabBarItem.items.iconName
                )
            }
            .tag(TabBarItem.items)
            
            GoldView()
                .tabItem {
                    Label(
                        TabBarItem.gold.title,
                        systemImage: TabBarItem.gold.iconName
                    )
                }
                .tag(TabBarItem.gold)
            
            SettingsView(locale: $currentLocale)
                .tabItem {
                    Label(
                        TabBarItem.settings.title,
                        systemImage: TabBarItem.settings.iconName
                    )
                }
                .tag(TabBarItem.settings)
        }
        .accentColor(.albionBrown)
        .onReceive(Just(tabSelection), perform: { newValue in
            UserDefaults.standard.tabSelection = newValue
        })
    }
}

#Preview {
    RouterView { _ in
        RootView()
    }
}
