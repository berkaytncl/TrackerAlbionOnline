//
//  ItemPriceDataService.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 15.07.2024.
//

import Foundation
import Combine
import SimpleNetworking

@MainActor
final class ItemPriceDataService {
    @Published private(set) var itemPrices: [ItemPriceResponse] = []
    
    private var itemPriceSubscription: AnyCancellable?
    
    func loadItemPriceData(item: String, server: Server) {
        getItemPriceData(urlString: server.itemPricesURL(item: item))
    }
    
    private func getItemPriceData(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        itemPriceSubscription = NetworkingManager.download(url: url)
            .decode(type: [ItemPriceResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] itemPrices in
                self?.itemPrices = itemPrices
            }
    }
}
