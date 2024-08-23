//
//  ItemsViewModel.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import Foundation
import SwiftfulRouting
import Combine

@MainActor
final class ItemsViewModel: ObservableObject {
    @Published private var items: [LocalizedItem] = []
    @Published private(set) var filteredItems: [LocalizedItem] = []
    @Published private(set) var favoritedItems: [String] = []
    @Published var isItemsFilteredFavorite: Bool = false
    @Published var tier: Tier = .all
    @Published var enchantment: Enchantment = .all
    @Published var searchText: String = ""
    
    var selectedLanguage: Language {
        languageManager.selectedLanguage
    }
    
    private let router: AnyRouter
    private let itemDataService: ItemsDataService
    private let languageManager: LanguageManager
    private let favoriteItemDataManager: FavoriteItemsDataManager
    private var cancellables = Set<AnyCancellable>()

    init(
        router: AnyRouter,
        itemDataService: ItemsDataService,
        languageManager: LanguageManager,
        favoriteItemDataManager: FavoriteItemsDataManager
    ) {
        self.router = router
        self.itemDataService = itemDataService
        self.languageManager = languageManager
        self.favoriteItemDataManager = favoriteItemDataManager
        addSubscribers()
    }
    
    private func addSubscribers() {
        itemDataService.$items
            .combineLatest($favoritedItems, $isItemsFilteredFavorite)
            .map(mapItemsToFavoritedItems)
            .sink { [weak self] returnedFavoritedItems in
                self?.items = returnedFavoritedItems
            }
            .store(in: &cancellables)
        
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .combineLatest($tier, $enchantment, $items)
            .map(mapItemsToFilteredItems)
            .sink { [weak self] returnedFilteredItems in
                self?.filteredItems = returnedFilteredItems
            }
            .store(in: &cancellables)
        
        favoriteItemDataManager.$savedEntities
            .sink { [weak self] returnedFavoritedItems in
                self?.favoritedItems = returnedFavoritedItems.compactMap { $0.itemId }
            }
            .store(in: &cancellables)
    }
    
    func getItemsData() async {
        await itemDataService.loadItemData()
    }

    private func mapItemsToFavoritedItems(items: [LocalizedItem], favoritedItems: [String], isItemsFilteredFavorite: Bool) -> [LocalizedItem] {
        guard isItemsFilteredFavorite else { return items }
       
        return items.compactMap { item -> LocalizedItem? in
            guard favoritedItems.first(where: { $0 == item.itemId }) != nil else { return nil }
            return item
        }
    }
    
    private func mapItemsToFilteredItems(text: String, tier: Tier, enchantment: Enchantment, items: [LocalizedItem]) -> [LocalizedItem] {
        guard tier != .all || enchantment != .all || !text.isEmpty else { return items }
       
        return items.compactMap { item -> LocalizedItem? in
            if tier != .all {
                guard item.uniqueName.contains(tier.uniqueNameStr) else { return nil }
            }
            
            if enchantment != .all {
                if enchantment == .zero {
                    guard !item.uniqueName.contains("@") else { return nil }
                } else {
                    guard item.uniqueName.contains(enchantment.uniqueNameStr) else { return nil }
                }
            }
            
            if !text.isEmpty {
                let itemDefaultName = item.localizedNames.getLocalizedText(for: .en)
                let itemLocalizedName = item.localizedNames.getLocalizedText(for: languageManager.selectedLanguage)
                guard itemDefaultName.lowercased().contains(text.lowercased()) || itemLocalizedName.lowercased().contains(text.lowercased()) else { return nil }
            }
            
            return item
        }
    }
    
    func updateFavoritedItems(id: String) {
        favoriteItemDataManager.updateFavoritedItems(id: id)
    }
    
    func goToDetailScreen(item: LocalizedItem) {
        router.showScreen(.push) { router in
            ItemPricesView(
                viewModel: ItemPricesViewModel(
                    router: router,
                    item: item,
                    itemPriceDataService: ItemPriceDataService(),
                    languageManager: LanguageManager.shared,
                    favoriteItemDataManager: FavoriteItemsDataManager.shared
                )
            )
        }
    }
}
