//
//  ItemPricesViewModel.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import Foundation
import Combine
import SwiftfulRouting

@MainActor
final class ItemPricesViewModel: ObservableObject {
    @Published private(set) var itemPrices: [ItemQuality: [ItemPrice]] = [:]
    @Published private(set) var favoritedItems: [String] = []
    @Published var item: LocalizedItem
    @Published var selectedServer: Server {
        didSet {
            UserDefaults.standard.selectedServer = selectedServer
        }
    }
    
    var itemIsFavorited: Bool {
        favoritedItems.contains(item.itemId)
    }
    
    private let router: AnyRouter
    private let itemPriceDataService = ItemPriceDataService()
    private let languageManager = LanguageManager.shared
    private let favoriteItemDataManager = FavoriteItemsDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(router: AnyRouter, item: LocalizedItem) {
        self.router = router
        self.item = item
        selectedServer = UserDefaults.standard.selectedServer
        addSubscribers()
    }
    
    private func addSubscribers() {
        $selectedServer
            .sink { [weak self] server in
                guard let self else { return }
                self.itemPriceDataService.loadItemPriceData(item: self.item.uniqueName, server: server)
            }
            .store(in: &cancellables)
        
        itemPriceDataService.$itemPrices
            .sink { [weak self] itemPrices in
                guard let self else { return }
                ItemQuality.allCases.forEach { quality in
                    self.itemPrices[quality] = []
                    var itemPriceFiltered: [ItemPrice] = []
                    
                    let items = itemPrices.filter { $0.quality == quality.rawValue }
                    items.forEach { item in
                        if let itemPrice = item.toItemPrices() {
                            itemPriceFiltered.append(itemPrice)
                        }
                    }
                    
                    self.itemPrices[quality] = itemPriceFiltered
                }
            }
            .store(in: &cancellables)
        
        favoriteItemDataManager.$savedEntities
            .sink { [weak self] returnedFavoritedItems in
                self?.favoritedItems = returnedFavoritedItems.compactMap { $0.itemId }
            }
            .store(in: &cancellables)
    }
    
    func updateFavoritedItems() {
        favoriteItemDataManager.updateFavoritedItems(id: item.itemId)
    }
    
    func localizedText(for item: LocalizedItem) -> (name: String, description: String) {
        let name = item.localizedNames.getLocalizedText(for: languageManager.selectedLanguage)
        let description = item.localizedDescriptions.getLocalizedText(for: languageManager.selectedLanguage)
        return (name, description)
    }
    
    func dismissScreen() {
        router.dismissScreen()
    }
}
