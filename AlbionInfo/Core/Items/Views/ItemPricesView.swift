//
//  ItemPricesView.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import SwiftUI
import SwiftfulRouting

struct ItemPricesView: View {
    @StateObject private var viewModel: ItemPricesViewModel
    
    init(router: AnyRouter, item: LocalizedItem) {
        _viewModel = StateObject(wrappedValue: ItemPricesViewModel(router: router, item: item))
    }
    
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
            title: LocalizedKey.itemPrice.localized,
            leftImageName: "arrow.uturn.left",
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
    RouterView { router in
        ItemPricesView(router: router, item: .mock)
    }
}
