//
//  GoldPriceDataService.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 16.07.2024.
//

import Foundation
import Combine
import SimpleNetworking

@MainActor
final class GoldPriceDataService {
    @Published private(set) var westGoldPrices: GoldPrices = []
    @Published private(set) var eastGoldPrices: GoldPrices = []
    @Published private(set) var europeGoldPrices: GoldPrices = []
    
    private var subscriptions: [Server: AnyCancellable] = [:]
    
    func loadGoldPriceData() {
        Server.allCases.forEach { server in
            subscriptions[server]?.cancel()
            subscriptions[server] = getGoldPriceData(
                urlString: server.goldPricesURL(date: "1-1-2018", endDate: endDate()),
                server: server
            )
        }
    }
    
    private func getGoldPriceData(urlString: String, server: Server) -> AnyCancellable? {
        guard let url = URL(string: urlString) else { return nil }
        
        return NetworkingManager.download(url: url)
            .decode(type: GoldPrices.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] goldPrices in
                self?.updateGoldData(goldPrices: goldPrices, server: server)
            }
    }
    
    private func updateGoldData(goldPrices: GoldPrices, server: Server) {
        switch server {
        case .west:
            westGoldPrices = goldPrices
        case .east:
            eastGoldPrices = goldPrices
        case .europe:
            europeGoldPrices = goldPrices
        }
    }
    
    private func endDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M-d-yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
}
