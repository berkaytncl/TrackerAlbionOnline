//
//  ItemsView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import SwiftUI
import SwiftfulRouting

struct ItemsView: View {
    @StateObject var viewModel: ItemsViewModel
    
    var body: some View {
        ZStack {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack {
                header
                
                SearchBarView(
                    prompt: LocalizedKey.searchPlaceholderItem.localized,
                    searchText: $viewModel.searchText
                )
                .padding(.bottom, 8)
                
                filterSection
                
                gridSection
                    .padding([.horizontal])
            }
            .padding(.bottom, 4)
        }
        .task {
            await viewModel.getItemsData()
        }
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
    }
    
    private var header: some View {
        ZStack(alignment: .trailing) {
            HeaderView(
                title: .items,
                isRootView: true
            )
            
            Group {
                if viewModel.isItemsFilteredFavorite {
                    Image(systemName: "star.fill")
                } else {
                    Image(systemName: "star")
                }
            }
            .padding(8)
            .background(.albionDarkBrown.opacity(0.001))
            .onTapGesture {
                viewModel.isItemsFilteredFavorite.toggle()
            }
            .padding(8)
            .font(.title3)
            .foregroundStyle(.albionBrown)
        }
    }
    
    private var filterSection: some View {
        VStack(spacing: 0) {
            HStack {
                Text(.tierLabel)
                FilterView(selection: $viewModel.tier)
            }
            
            HStack {
                Text(.enchantment)
                FilterView(selection: $viewModel.enchantment)
            }
        }
        .padding(.horizontal)
    }
    
    private var gridSection: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 2),
                alignment: .center,
                spacing: 0,
                pinnedViews: []
            ) {
                ForEach(Array(viewModel.filteredItems.enumerated()), id: \.offset) { index, item in
                    ItemCell(
                        name: item.localizedNames.getLocalizedText(for: viewModel.selectedLanguage),
                        uniqueName: item.uniqueName,
                        isFavorited: viewModel.favoritedItems.contains(item.itemId)
                    ) {
                        viewModel.updateFavoritedItems(id: item.itemId)
                    }
                    .background(index % 4 == 1 || index % 4 == 2 ? .rowBackground : .darkRowBackground)
                    .onTapGesture {
                        viewModel.goToDetailScreen(item: item)
                    }
                }
            }
        }
    }
}

#Preview {
    RouterView { router in
        ItemsView(
            viewModel: ItemsViewModel(
                router: router,
                itemDataService: ItemsDataService(),
                languageManager: LanguageManager.shared,
                favoriteItemDataManager: FavoriteItemsDataManager.shared
            )
        )
    }
}
