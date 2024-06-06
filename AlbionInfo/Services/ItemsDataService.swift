//
//  ItemsDataService.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import Foundation

@MainActor
final class ItemsDataService {
    @Published private(set) var items: [LocalizedItem] = []
    
    func loadItemData() async {
        guard let url = Bundle.main.url(forResource: "items", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let responseItemsData = try JSONDecoder().decode([LocalizedItemResponse].self, from: data)
            let localizedItems = responseItemsData.compactMap { response -> LocalizedItem? in
                if let names = response.localizedNames,
                   let descriptions = response.localizedDescriptions {
                    return LocalizedItem(
                        localizedNames: names,
                        localizedDescriptions: descriptions,
                        itemId: response.itemId,
                        uniqueName: response.uniqueName
                    )
                } else {
                    return nil
                }
            }
            
            await MainActor.run { [weak self] in
                self?.items = localizedItems
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
