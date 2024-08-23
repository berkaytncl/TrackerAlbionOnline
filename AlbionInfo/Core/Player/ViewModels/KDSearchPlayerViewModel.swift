//
//  KDTrackPlayerViewModel.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.07.2024.
//

import Foundation
import SwiftfulRouting
import Combine

@MainActor
final class KDSearchPlayerViewModel: ObservableObject {
    @Published private(set) var searchedPlayers: [Server: [PlayerServerData]] = [:]
    @Published private(set) var favoritedPlayers: [Player] = []
    @Published var searchText = ""
    @Published private(set) var requestedSearchText = ""
    @Published private(set) var serverIsLoading: [Server: Bool] = [:]
    
    private let router: AnyRouter
    private let playerSearchDataService: PlayerSearchDataService
    private let favoritePlayerDataManager: FavoritePlayerDataManager
    private var cancellables = Set<AnyCancellable>()
    
    init(
        router: AnyRouter,
        playerSearchDataService: PlayerSearchDataService,
        favoritePlayerDataManager: FavoritePlayerDataManager
    ) {
        self.router = router
        self.playerSearchDataService = playerSearchDataService
        self.favoritePlayerDataManager = favoritePlayerDataManager
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .debounce(for: .seconds(0.7), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                Task {
                    await self?.getPlayerData(name: text)
                }
                self?.requestedSearchText = text
            }
            .store(in: &cancellables)
        
        playerSearchDataService.$westSearchedPlayers
            .sink { [weak self] searchedPlayers in
                self?.searchedPlayers[.west] = searchedPlayers
                self?.serverIsLoading[.west] = false
            }
            .store(in: &cancellables)
        
        playerSearchDataService.$eastSearchedPlayers
            .sink { [weak self] searchedPlayers in
                self?.searchedPlayers[.east] = searchedPlayers
                self?.serverIsLoading[.east] = false
            }
            .store(in: &cancellables)
        
        playerSearchDataService.$europeSearchedPlayers
            .sink { [weak self] searchedPlayers in
                self?.searchedPlayers[.europe] = searchedPlayers
                self?.serverIsLoading[.europe] = false
            }
            .store(in: &cancellables)
        
        favoritePlayerDataManager.$savedEntities
            .sink { [weak self] returnedFavoritedPlayers in
                guard let self else { return }
                self.favoritedPlayers = returnedFavoritedPlayers.compactMap { entity -> Player? in
                    guard let id = entity.id,
                          let name = entity.name,
                          let strServer = entity.server,
                          let server = Server(rawValue: strServer) else { return nil }
                    return Player(id: id, name: name, server: server, tracked: entity.tracked)
                }
            }
            .store(in: &cancellables)
    }
    
    func getPlayerData(name: String) async {
        Server.allCases.forEach {
            searchedPlayers[$0] = nil
            serverIsLoading[$0] = true
        }
        guard !name.isEmpty else {
            Server.allCases.forEach { serverIsLoading[$0] = false }
            return
        }
        playerSearchDataService.loadPlayersData(name: name, server: .west)
        playerSearchDataService.loadPlayersData(name: name, server: .east)
        playerSearchDataService.loadPlayersData(name: name, server: .europe)
    }
    
    func addFavoritePlayer(id: String, name: String, server: Server) {
        favoritePlayerDataManager.add(player: Player(id: id, name: name, server: server, tracked: true))
    }
    
    func dismissScreen() {
        router.dismissScreen()
    }
}
