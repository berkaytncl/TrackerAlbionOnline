//
//  KDSettingsView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 12.07.2024.
//

import SwiftUI
import SwiftfulRouting
import SwiftfulUI

struct KDSettingsView: View {
    @StateObject private var viewModel: KDSettingsViewModel
    
    @AppStorage("reports_type_filter")
    private var reportsType: ReportsType = .both
    @AppStorage("sort_by_filter")
    private var sortBy: SortBy = .time
    @AppStorage("order_type_filter")
    private var orderType: OrderType = .ascending
    
    init(router: AnyRouter) {
        _viewModel = StateObject(wrappedValue: KDSettingsViewModel(router: router))
    }
    
    var body: some View {
        ZStack {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack {
                header
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(.reportsType)
                    FilterView(selection: $reportsType)
                        .padding(.bottom, 24)
                    
                    Text(.sortBy)
                    FilterView(selection: $sortBy)
                        .padding(.bottom, 24)
                    
                    Text(.sortOrder)
                    FilterView(selection: $orderType)
                        .padding(.bottom, 24)
                    
                    Text(.server)
                    FilterView(selection: $viewModel.selectedServer)
                        .padding(.bottom, 24)
                    
                    Text(.trackedPlayers)
                    ScrollView(.vertical, showsIndicators: false) {
                        trackedPlayersSection
                    }
                }
                .padding()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
    }
    
    private var header: some View {
        HeaderView(
            title: LocalizedKey.playerSettings.localized,
            leftImageName: "arrow.uturn.left",
            leftBarItemPressed: viewModel.dismissScreen
        )
    }
    
    private var trackedPlayersSection: some View {
        LazyVStack {
            ForEach(viewModel.filteredPlayers, id: \.id) { player in
                TrackedPlayersCell(
                    id: player.id,
                    name: player.name,
                    server: player.server,
                    tracked: player.tracked
                ) {
                    viewModel.deleteFavoritedPlayer(id: player.id, server: player.server)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .asButton {
                    viewModel.updateTracked(player: player)
                }
                .if(player.tracked) { view in
                    view.shadow(radius: 5)
                }
                .padding(.horizontal)
                .padding(.bottom, 6)
            }
            .padding(.top)
        }
    }
}

#Preview {
    RouterView { router in
        KDSettingsView(router: router)
    }
}
