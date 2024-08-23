//
//  KDReportDataService.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 8.07.2024.
//

import Foundation
import Combine

@MainActor
final class KDReportDataService {
    @Published private(set) var killReports: [KDReportResponse] = []
    @Published private(set) var deathReports: [KDReportResponse] = []
    
    private var kdReportSubscription = Set<AnyCancellable>()
    
    func clearKDReportData() {
        killReports.removeAll()
        deathReports.removeAll()
    }
    
    func loadKDReportData(id: String, server: Server) {
        getReportData(urlString: server.playerLastTenKillURL(id: id)) { [weak self] in
            self?.killReports.append(contentsOf: $0)
        }
        getReportData(urlString: server.playerLastTenDeathURL(id: id)) { [weak self] in
            self?.deathReports.append(contentsOf: $0)
        }
    }
    
    private func getReportData(urlString: String, completion: @escaping (([KDReportResponse]) -> Void)) {
        guard let url = URL(string: urlString) else { return }
        
        NetworkManager.download(url: url)
            .decode(type: [KDReportResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion) { kdReport in
                completion(kdReport)
            }
            .store(in: &kdReportSubscription)
    }
}
