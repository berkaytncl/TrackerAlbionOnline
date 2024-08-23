//
//  KDInfoViewModel.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import Foundation
import SwiftfulRouting
import Combine

@MainActor
final class KDInfoViewModel: ObservableObject {
    @Published private(set) var players: [Player] = []
    @Published private var filteredKDReports: [KDReportResponse] = []
    @Published private(set) var kdReports: [KDReportResponse] = []
    
    @Published private(set) var reportsType: ReportsType
    @Published private(set) var sortBy: SortBy
    @Published private(set) var orderType: OrderType
    
    private let router: AnyRouter
    private let kdReportDataService: KDReportDataService
    private let favoritePlayerDataManager: FavoritePlayerDataManager
    private var cancellables = Set<AnyCancellable>()
    
    init(
        router: AnyRouter,
        kdReportDataService: KDReportDataService,
        favoritePlayerDataManager: FavoritePlayerDataManager
    ) {
        self.router = router
        self.kdReportDataService = kdReportDataService
        self.favoritePlayerDataManager = favoritePlayerDataManager
        reportsType = UserDefaults.standard.reportsType
        sortBy = UserDefaults.standard.sortBy
        orderType = UserDefaults.standard.orderType
        addSubscribers()
    }
    
    private func addSubscribers() {
        favoritePlayerDataManager.$savedEntities
            .sink { [weak self] returnedFavoritedPlayers in
                guard let self else { return }
                self.players = returnedFavoritedPlayers.compactMap {
                    guard let id = $0.id,
                          let name = $0.name,
                          let strServer = $0.server,
                          let server = Server(rawValue: strServer) else { return nil }
                    return Player(id: id, name: name, server: server, tracked: $0.tracked)
                }
                
                self.refreshKDReportData()
            }
            .store(in: &cancellables)
        
        kdReportDataService.$killReports
            .combineLatest(kdReportDataService.$deathReports, $players, $reportsType)
            .map(mapFilterKDReports)
            .sink { [weak self] kdReports in
                self?.filteredKDReports = kdReports
            }
            .store(in: &cancellables)
        
        $filteredKDReports
            .combineLatest($sortBy, $orderType)
            .map(mapSortKDReports)
            .sink { [weak self] kdReports in
                self?.kdReports = kdReports
            }
            .store(in: &cancellables)
    }
    
    private func mapFilterKDReports(killReports: [KDReportResponse], deathReports: [KDReportResponse], players: [Player], reportsType: ReportsType) -> [KDReportResponse] {
        let trackedPlayerIds = players.filter { $0.tracked }.map { $0.id }
        
        let kReports = killReports.filter { trackedPlayerIds.contains($0.killer?.id ?? "") }
        let dReports = deathReports.filter { trackedPlayerIds.contains($0.victim.id) }
        return switch reportsType {
        case .both:
            Array(Set((kReports + dReports).filter { report in
                (kReports + dReports).filter { $0.eventID == report.eventID }.count == 1
            }))
        case .kills:
            kReports
        case .deaths:
            dReports
        }
    }
    
    private func mapSortKDReports(kdReports: [KDReportResponse], sortBy: SortBy, orderType: OrderType) -> [KDReportResponse] {
        sortBy == .time ?
        sortTimeKDReports(kdReports: kdReports, orderType: orderType) :
        sortFameKDReports(kdReports: kdReports, orderType: orderType)
    }
    
    private func sortTimeKDReports(kdReports: [KDReportResponse], orderType: OrderType) -> [KDReportResponse] {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return kdReports.sorted {
            guard let date1 = isoFormatter.date(from: $0.timeStamp),
                  let date2 = isoFormatter.date(from: $1.timeStamp) else {
                return false
            }
            
            switch orderType {
            case .ascending:
                return date1 < date2
            case .descending:
                return date1 > date2
            }
        }
    }
    
    private func sortFameKDReports(kdReports: [KDReportResponse], orderType: OrderType) -> [KDReportResponse] {
        switch orderType {
        case .ascending:
            return kdReports.sorted { $0.killFame < $1.killFame }
        case .descending:
            return kdReports.sorted { $0.killFame > $1.killFame }
        }
    }
    
    func refreshKDReportData() {
        kdReportDataService.clearKDReportData()
        for player in players {
            kdReportDataService.loadKDReportData(id: player.id, server: player.server)
        }
    }
    
    func updateSortAndFilterData() {
        reportsType = UserDefaults.standard.reportsType
        sortBy = UserDefaults.standard.sortBy
        orderType = UserDefaults.standard.orderType
    }
    
    func goKDDetailScreen(kdReport: KDReportResponse) {
        router.showScreen(.fullScreenCover) { router in
            KDDetailView(
                router: router,
                kdReport: kdReport
            )
        }
    }
    
    func goKDTrackPlayerScreen() {
        router.showScreen(.push) { router in
            KDSearchPlayerView(
                viewModel: KDSearchPlayerViewModel(
                    router: router,
                    playerSearchDataService: PlayerSearchDataService(),
                    favoritePlayerDataManager: FavoritePlayerDataManager.shared
                )
            )
        }
    }
    
    func goKDSettingsScreen() {
        router.showScreen(.push) { router in
            KDSettingsView(
                viewModel: KDSettingsViewModel(
                    router: router,
                    favoritePlayerDataManager: FavoritePlayerDataManager.shared
                )
            )
        }
    }
}
