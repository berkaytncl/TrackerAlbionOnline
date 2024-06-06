//
//  ChartViewModel.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 18.07.2024.
//

import Foundation
import Combine
import SwiftfulRouting

@MainActor
final class ChartViewModel: ObservableObject {
    @Published private var serverGoldPricesDict: [Server: GoldPrices] = [:]
    @Published private(set) var prices: [Int] = []
    @Published private(set) var maxY: Int = 0
    @Published private(set) var minY: Int = 0
    @Published private(set) var startDate: Date?
    @Published private(set) var endDate: Date?
    @Published private(set) var lastPrice: Int?
    @Published var selectedServer: Server {
        didSet {
            UserDefaults.standard.selectedServer = selectedServer
        }
    }
    
    private let goldPriceDataService = GoldPriceDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        selectedServer = UserDefaults.standard.selectedServer
        addSubscribers()
    }
    
    private func addSubscribers() {
        goldPriceDataService.$westGoldPrices
            .sink { [weak self] goldPrices in
                guard let self else { return }
                serverGoldPricesDict[.west] = goldPrices
                if selectedServer == .west {
                    setSelectedServerData(goldPrices: goldPrices)
                }
            }
            .store(in: &cancellables)
        
        goldPriceDataService.$eastGoldPrices
            .sink { [weak self] goldPrices in
                guard let self else { return }
                serverGoldPricesDict[.east] = goldPrices
                if selectedServer == .east {
                    setSelectedServerData(goldPrices: goldPrices)
                }
            }
            .store(in: &cancellables)
        
        goldPriceDataService.$europeGoldPrices
            .sink { [weak self] goldPrices in
                guard let self else { return }
                serverGoldPricesDict[.europe] = goldPrices
                if selectedServer == .europe {
                    setSelectedServerData(goldPrices: goldPrices)
                }
            }
            .store(in: &cancellables)
        
        $selectedServer
            .sink { [weak self] server in
                guard let self,
                      let goldPrices = self.serverGoldPricesDict[server] else { return }
                setSelectedServerData(goldPrices: goldPrices)
            }
            .store(in: &cancellables)
    }
    
    func setSelectedServerData(goldPrices: GoldPrices) {
        prices = goldPrices.map { $0.price }
        
        maxY = goldPrices.map { $0.price }.max() ?? 0
        minY = goldPrices.map { $0.price }.min() ?? 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: Language.en.rawValue)
        startDate = dateFormatter.date(from: goldPrices.first?.timestamp ?? "")
        endDate = dateFormatter.date(from: goldPrices.last?.timestamp ?? "")
        
        lastPrice = prices.last
    }
    
    func getGoldData() {
        goldPriceDataService.loadGoldPriceData()
    }
}
