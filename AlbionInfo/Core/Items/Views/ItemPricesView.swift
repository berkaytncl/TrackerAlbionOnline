//
//  ItemPricesView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import SwiftUI
import SwiftfulRouting

struct ItemPricesView: View {
    @StateObject var viewModel: ItemPricesViewModel
    
    var body: some View {
        ZStack {
            Color.albionDarkBrown.ignoresSafeArea()
            
            VStack(spacing: 4) {
                header
                
                FilterView(selection: $viewModel.selectedServer)
                    .padding(.bottom)
                
                itemSection
                scrollViewSection
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
    }
    
    private var header: some View {
        HeaderView(
            title: .itemPrice,
            leftBarItemPressed: viewModel.dismissScreen
        )
    }
    
    private var itemSection: some View {
        VStack(alignment: .leading) {
            let localizedText = viewModel.localizedText(for: viewModel.item)
            HStack {
                ZStack {
                    Image(systemName: "star.fill")
                        .opacity(viewModel.itemIsFavorited ? 1 : 0)
                        .rotationEffect(.degrees(viewModel.itemIsFavorited ? 0 : 180))
                    Image(systemName: "star")
                        .opacity(viewModel.itemIsFavorited ? 0 : 1)
                        .rotationEffect(.degrees(viewModel.itemIsFavorited ? -180 : 0))
                }
                .onTapGesture {
                    viewModel.updateFavoritedItems()
                }
                .animation(.bouncy, value: viewModel.itemIsFavorited)
                
                Text(localizedText.name)
                    .font(.title2)
            }
            .padding(.bottom, 6)
            
            Text(localizedText.description)
                .font(.caption)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    private var scrollViewSection: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(ItemQuality.allCases, id: \.self) { quality in
                if let items = viewModel.itemPrices[quality],
                    !items.isEmpty{
                    ItemPriceCell(items: items)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .padding(.bottom, 6)
                }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    let item: LocalizedItem = .mock
    
    return RouterView { router in
        ItemPricesView(
            viewModel: ItemPricesViewModel(
                router: router,
                item: item,
                itemPriceDataService: ItemPriceDataService(),
                languageManager: LanguageManager.shared,
                favoriteItemDataManager: FavoriteItemsDataManager.shared
            )
        )
    }
}
