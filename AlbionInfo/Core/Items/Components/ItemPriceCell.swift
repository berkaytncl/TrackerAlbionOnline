//
//  ItemPriceCell.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 15.07.2024.
//

import SwiftUI

struct ItemPriceCell: View {
    var items: [ItemPrice]
    private let minSellPrice: Int
    private let maxBuyPrice: Int
    
    init(items: [ItemPrice]) {
        self.items = items
        
        let sortSellPrice = items.filter { $0.sellPriceMin > 0 }.sorted(by: { $0.sellPriceMin < $1.sellPriceMin })
        let sortBuyPrice = items.sorted(by: { $0.buyPriceMax > $1.buyPriceMax })
        minSellPrice = sortSellPrice.first?.sellPriceMin ?? 0
        maxBuyPrice = sortBuyPrice.first?.buyPriceMax ?? 0
    }
    
    var body: some View {
        VStack(spacing: 2) {
            if let firstItem = items.first {
                itemImageAndQualitySection(item: firstItem)
                itemInfoSection(firstItem: firstItem)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .padding(.horizontal, 4)
        .lineLimit(1)
        .fontWeight(.medium)
        .foregroundStyle(.albionDarkBrown)
        .background(.albionBrown)
    }
    
    private func itemImageAndQualitySection(item: ItemPrice) -> some View {
        HStack {
            EquipmentCell(
                equipmentData: EquipmentData(
                    count: 1,
                    quality: item.quality.rawValue,
                    itemId: item.itemId
                )
            )
            .frame(width: 80, height: 80)
            
            Text(item.quality.localizedDescription)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func itemInfoSection(firstItem: ItemPrice) -> some View {
        VStack {
            ForEach(items, id: \.id) { item in
                firstLineTable(firstItem: firstItem, item: item)
                tableLine(item: item)
            }
        }
    }
    
    @ViewBuilder
    private func firstLineTable(firstItem: ItemPrice, item: ItemPrice) -> some View {
        HStack(spacing: 2) {
            if firstItem.id == item.id {
                Text(.city)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 2) {
                    Text(.sell)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text(.buy)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .fontWeight(.semibold)
    }
    
    private func tableLine(item: ItemPrice) -> some View {
        HStack(spacing: 2) {
            Text(item.city)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 2) {
                Text(item.sellPriceMin.abbreviated)
                    .if(item.sellPriceMin == minSellPrice && item.sellPriceMin != 0, transform: { view in
                        view.foregroundStyle(.green)
                    })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text(item.buyPriceMax.abbreviated)
                    .if(item.buyPriceMax == maxBuyPrice && item.buyPriceMax != 0, transform: { view in
                        view.foregroundStyle(.red)
                    })
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

#Preview {
    ItemPriceCell(
        items: [
            .mock,
            .mock,
            .mock,
            .mock,
            .mock,
            .mock,
            .mock
        ]
    )
}
