//
//  ItemPrice.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 15.07.2024.
//

import Foundation

struct ItemPriceResponse: Codable {
    let itemId, city: String
    let quality, sellPriceMin, buyPriceMax: Int
    
    enum CodingKeys: String, CodingKey {
        case itemId = "item_id"
        case city
        case quality
        case sellPriceMin = "sell_price_min"
        case buyPriceMax = "buy_price_max"
    }
    
    func toItemPrices() -> ItemPrice? {
        guard let itemQuality = ItemQuality(rawValue: quality) else { return nil }
        return ItemPrice(
            itemId: itemId,
            city: city,
            quality: itemQuality,
            sellPriceMin: sellPriceMin,
            buyPriceMax: buyPriceMax
        )
    }
}

struct ItemPrice: Identifiable {
    let itemId, city: String
    let quality: ItemQuality
    let sellPriceMin, buyPriceMax: Int

    var id: String {
        itemId + city + quality.rawValue.description
    }
}

extension ItemPrice {
    static let mock: ItemPrice = {
        .init(
            itemId: "T4_BAG",
            city: "Bridgewatch",
            quality: .one,
            sellPriceMin: 2944,
            buyPriceMax: 2305
        )
    }()
}
