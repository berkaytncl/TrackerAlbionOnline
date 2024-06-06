//
//  GoldPrice.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 17.07.2024.
//

import Foundation

typealias GoldPrices = [GoldPriceResponse]

struct GoldPriceResponse: Codable {
    let price: Int
    let timestamp: String
}

extension GoldPrices {
    static let mock: GoldPrices = {
        [
            .init(price: 4861, timestamp: "2024-07-16T19:00:00"),
            .init(price: 4848, timestamp: "2024-07-16T20:00:00"),
            .init(price: 4839, timestamp: "2024-07-16T21:00:00"),
            .init(price: 4833, timestamp: "2024-07-16T22:00:00"),
            .init(price: 4827, timestamp: "2024-07-16T23:00:00"),
            .init(price: 4809, timestamp: "2024-07-17T00:00:00"),
            .init(price: 4810, timestamp: "2024-07-17T01:00:00"),
            .init(price: 4861, timestamp: "2024-07-17T02:00:00"),
            .init(price: 4876, timestamp: "2024-07-17T03:00:00"),
            .init(price: 4893, timestamp: "2024-07-17T04:00:00"),
            .init(price: 4907, timestamp: "2024-07-17T05:00:00"),
            .init(price: 4919, timestamp: "2024-07-17T06:00:00"),
            .init(price: 4904, timestamp: "2024-07-17T07:00:00")
        ]
    }()
}
