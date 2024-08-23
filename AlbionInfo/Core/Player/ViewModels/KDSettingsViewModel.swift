//
//  KDSettingsViewModel.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 12.07.2024.
//

import Foundation
import SwiftfulRouting
import Combine

@MainActor
final class KDSettingsViewModel: ObservableObject {
    @Published private var players: [Player] = []
    @Published private(set) var filteredPlayers: [Player] = []
    @Published var selectedServer: Server {
        didSet {
            UserDefaults.standard.selectedServer = selectedServer
        }
    }
    
    private let router: AnyRouter
    private let favoritePlayerDataManager: FavoritePlayerDataManager
    private var cancellables = Set<AnyCancellable>()
    
    init(
        router: AnyRouter,
        favoritePlayerDataManager: FavoritePlayerDataManager
    ) {
        self.router = router
        self.favoritePlayerDataManager = favoritePlayerDataManager
        selectedServer = UserDefaults.standard.selectedServer
        addSubscribers()
    }
    
    private func addSubscribers() {
        favoritePlayerDataManager.$savedEntities
            .sink { [weak self] favoritedPlayers in
                self?.players = favoritedPlayers.compactMap {
                    guard let id = $0.id,
                          let name = $0.name,
                          let serverStr = $0.server,
                          let server = Server(rawValue: serverStr) else { return nil }
                    return Player(id: id, name: name, server: server, tracked: $0.tracked)
                }
            }
            .store(in: &cancellables)
        
        $players
            .combineLatest($selectedServer)
            .map(mapFavoritePlayersToFilterServer)
            .sink { [weak self] filteredFavoritePlayers in
                self?.filteredPlayers = filteredFavoritePlayers
            }
            .store(in: &cancellables)
    }
    
    private func mapFavoritePlayersToFilterServer(players: [Player], server: Server) -> [Player] {
        return players.filter { $0.server == server }
    }
    
    func updateTracked(player: Player) {
        favoritePlayerDataManager.update(player: player)
    }
    
    func deleteFavoritedPlayer(id: String, server: Server) {
        favoritePlayerDataManager.delete(id: id, server: server)
    }
    
    func dismissScreen() {
        router.dismissScreen()
    }
}
