//
//  ItemsView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import SwiftUI
import SwiftfulRouting
import SwiftfulUI

struct ItemsView: View {
    @StateObject private var viewModel: ItemsViewModel
    
    init(router: AnyRouter) {
        _viewModel = StateObject(wrappedValue: ItemsViewModel(router: router))
    }
    
    var body: some View {
        ZStack {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack {
                header
                SearchBarView(prompt: LocalizedKey.searchPlaceholderItem.localized, searchText: $viewModel.searchText)
                    .padding(.bottom, 8)
                filterSection
                gridSection
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding([.horizontal, .bottom])
            }
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
                title: LocalizedKey.items.localized,
                leftImageName: "arrow.uturn.left",
                leftBarItemPressed: viewModel.dismissScreen
            )
            
            Group {
                if viewModel.isItemsFilteredFavorite {
                    Image(systemName: "star.fill")
                } else {
                    Image(systemName: "star")
                }
            }
            .foregroundStyle(.albionBrown)
            .asButton(.tap) {
                viewModel.isItemsFilteredFavorite.toggle()
            }
            .font(.title2)
            .padding(.horizontal)
            .padding(.vertical, 6)
        }
    }
    
    private var filterSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(.tierLabel)
            FilterView(selection: $viewModel.tier)
                .padding(.bottom, 12)
            
            Text(.enchantment)
            FilterView(selection: $viewModel.enchantment)
                .padding(.bottom, 12)
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
        ItemsView(router: router)
    }
}
