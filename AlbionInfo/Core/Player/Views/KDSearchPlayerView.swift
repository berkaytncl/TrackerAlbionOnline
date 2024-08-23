//
//  KDSearchPlayerView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.07.2024.
//

import SwiftUI
import SwiftfulRouting

struct KDSearchPlayerView: View {
    @StateObject var viewModel: KDSearchPlayerViewModel
    
    var body: some View {
        ZStack {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack {
                header
                SearchBarView(
                    prompt: LocalizedKey.searchPlaceholderPlayer.localized,
                    searchText: $viewModel.searchText
                )
                scrollViewSection
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .refreshable {
            await viewModel.getPlayerData(name: viewModel.searchText)
        }
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
    }
    
    private var header: some View {
        HeaderView(
            title: .searchPlayer,
            leftBarItemPressed: viewModel.dismissScreen
        )
    }
    
    private var scrollViewSection: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(Server.allCases, id: \.self) { server in
                if let isLoading = viewModel.serverIsLoading[server],
                   !viewModel.requestedSearchText.isEmpty {
                    Text(server.rawValue.capitalized.description)
                        .font(.title2)
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .albionBrown))
                            .foregroundStyle(.albionWhite)
                            .scaleEffect(1.5)
                            .padding(.bottom, 8)
                    } else if (viewModel.searchedPlayers[server] ?? []).isEmpty {
                        Text(.noPlayerMatchingFound, with: viewModel.requestedSearchText)
                            .padding(.vertical, 6)
                            .padding(.bottom, 2)
                    }
                }
                ForEach(viewModel.searchedPlayers[server] ?? [], id: \.playerData.id) { player in
                    SearchedPlayerInfoCell(player: player)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .if(!viewModel.favoritedPlayers
                            .map { $0.id }
                            .contains(player.playerData.id)
                        ) { view in
                            view
                                .onTapGesture {
                                    viewModel.addFavoritePlayer(
                                        id: player.playerData.id,
                                        name: player.playerData.name,
                                        server: player.server
                                    )
                                }
                                .shadow(radius: 5)
                        } else: { view in
                            view.opacity(0.5)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 6)
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    RouterView { router in
        KDSearchPlayerView(
            viewModel: KDSearchPlayerViewModel(
                router: router,
                playerSearchDataService: PlayerSearchDataService(),
                favoritePlayerDataManager: FavoritePlayerDataManager.shared
            )
        )
    }
}
