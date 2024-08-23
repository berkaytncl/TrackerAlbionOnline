//
//  KDDetailViewModel.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 23.08.2024.
//

import Foundation
import SwiftfulRouting
import Combine

@MainActor
final class KDDetailViewModel: ObservableObject {
    let kdReport: KDReportResponse
    
    private let router: AnyRouter
    private let itemDataService: ItemsDataService
    private let languageManager: LanguageManager
    private var cancellables = Set<AnyCancellable>()

    init(
        router: AnyRouter,
        kdReport: KDReportResponse,
        itemDataService: ItemsDataService,
        languageManager: LanguageManager
    ) {
        self.router = router
        self.kdReport = kdReport
        self.itemDataService = itemDataService
        self.languageManager = languageManager
    }
    
    func goToItemDetailScreen(itemId: String) {
        guard let item = getItem(with: itemId) else { return }
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
    
    private func getItem(with itemId: String) -> LocalizedItem? {
        itemDataService.items.first { item in
            item.uniqueName == itemId
        }
    }
    
    func dismissScreen() {
        router.dismissScreen()
    }
}
