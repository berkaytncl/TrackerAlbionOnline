//
//  PlayerDataService.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 8.07.2024.
//

import Foundation
import Combine
import SimpleNetworking

final class PlayerSearchDataService {
    @Published private(set) var westSearchedPlayers: [PlayerServerData] = []
    @Published private(set) var eastSearchedPlayers: [PlayerServerData] = []
    @Published private(set) var europeSearchedPlayers: [PlayerServerData] = []
    
    private var subscriptions: [Server: AnyCancellable] = [:]
    
    func loadPlayersData(name: String, server: Server) {
        let urlString = server.playerStatsURL(name: name)
        subscriptions[server]?.cancel()
        subscriptions[server] = getPlayersData(urlString: urlString, server: server)
    }
    
    private func getPlayersData(urlString: String, server: Server) -> AnyCancellable? {
        guard let url = URL(string: urlString) else { return nil }
        
        return NetworkingManager.download(url: url)
            .decode(type: PlayerResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] playersData in
                self?.updatePlayersData(playersData: playersData.players, server: server)
            }
    }
    
    private func updatePlayersData(playersData: [PlayerData], server: Server) {
        switch server {
        case .west:
            westSearchedPlayers = playersData.map {
                PlayerServerData(playerData: $0, server: .west)
            }
        case .east:
            eastSearchedPlayers = playersData.map {
                PlayerServerData(playerData: $0, server: .east)
            }
        case .europe:
            europeSearchedPlayers = playersData.map {
                PlayerServerData(playerData: $0, server: .europe)
            }
        }
    }
}
