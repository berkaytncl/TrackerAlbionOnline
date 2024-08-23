//
//  FavoritePlayerDataManager.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import Foundation
import CoreData

@MainActor
final class FavoritePlayerDataManager {
    static let shared = FavoritePlayerDataManager()
    
    private let container: NSPersistentContainer
    private let containerName: String = "FavoritePlayerContainer"
    private let entityName: String = "FavoritePlayerEntity"
    
    @Published private(set) var savedEntities: [FavoritePlayerEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                debugPrint("Error loading Core Data! \(error)")
            }
            self.getSavedFavoritePlayers()
        }
    }
    
    // MARK: PUBLIC
    
    func add(player: Player) {
        if savedEntities.first(where: { $0.id == player.id && $0.server == player.server.rawValue }) != nil {
            return
        }
        let entity = FavoritePlayerEntity(context: container.viewContext)
        entity.id = player.id
        entity.name = player.name
        entity.server = player.server.rawValue
        entity.tracked = player.tracked
        applyChanges()
    }
    
    func update(player: Player) {
        if let entity = savedEntities.first(where: { $0.id == player.id && $0.server == player.server.rawValue }) {
            entity.tracked.toggle()
            applyChanges()
        }
    }
    
    func delete(id: String, server: Server) {
        if let entity = savedEntities.first(where: { $0.id == id && $0.server == server.rawValue }) {
            container.viewContext.delete(entity)
            applyChanges()
        }
    }
    
    // MARK: PRIVATE
    
    private func getSavedFavoritePlayers() {
        let request = NSFetchRequest<FavoritePlayerEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            debugPrint("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getSavedFavoritePlayers()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            debugPrint("Error saving to Core Data. \(error)")
        }
    }
}
