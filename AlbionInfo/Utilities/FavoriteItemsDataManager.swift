//
//  FavoriteItemsDataManager.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 12.06.2024.
//

import Foundation
import CoreData

@MainActor
final class FavoriteItemsDataManager {
    static let shared = FavoriteItemsDataManager()

    private let container: NSPersistentContainer
    private let containerName: String = "FavoriteItemContainer"
    private let entityName: String = "FavoriteItemEntity"
    
    @Published private(set) var savedEntities: [FavoriteItemEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                debugPrint("Error loading Core Data! \(error)")
            }
            self.getSavedFavoriteLocations()
        }
    }
    
    // MARK: PUBLIC
    
    func updateFavoritedItems(id: String) {
        if let entity = savedEntities.first(where: { $0.itemId == id }) {
            delete(entity: entity)
        } else {
            add(id: id)
        }
    }
    
    // MARK: PRIVATE
    
    private func getSavedFavoriteLocations() {
        let request = NSFetchRequest<FavoriteItemEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            debugPrint("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func add(id: String) {
        let entity = FavoriteItemEntity(context: container.viewContext)
        entity.itemId = id
        applyChanges()
    }
    
    private func delete(entity: FavoriteItemEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getSavedFavoriteLocations()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            debugPrint("Error saving to Core Data. \(error)")
        }
    }
}
