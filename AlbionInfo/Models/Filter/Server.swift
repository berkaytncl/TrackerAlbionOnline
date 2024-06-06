//
//  Server.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 9.06.2024.
//

import Foundation

enum Server: String, Filter {
    case west
    case east
    case europe
    
    var localizedDescription: String {
        switch self {
        case .west:
            LocalizedKey.west.localized
        case .east:
            LocalizedKey.east.localized
        case .europe:
            LocalizedKey.europe.localized
        }
    }
}

// MARK: Item
extension Server {
    private var aodBaseURL: String {
        "https://\(self.rawValue).albion-online-data.com"
    }
    
    func itemPricesURL(item: String) -> String {
        aodBaseURL + "/api/v2/stats/prices/\(item)"
    }
    
    func goldPricesURL(date: String, endDate: String) -> String {
        aodBaseURL + "/api/v2/stats/gold?date=\(date)&end_date=\(endDate)"
    }
}

// MARK: Player
extension Server {
    func playerStatsURL(name: String) -> String {
        switch self {
        case .west: "https://gameinfo.albiononline.com/api/gameinfo/search?q=\(name)"
        case .east: "https://gameinfo-sgp.albiononline.com/api/gameinfo/search?q=\(name)"
        case .europe: "https://gameinfo-ams.albiononline.com/api/gameinfo/search?q=\(name)"
        }
    }
    
    func playerLastTenKillURL(id: String) -> String {
        switch self {
        case .west: "https://gameinfo.albiononline.com/api/gameinfo/players/\(id)/kills"
        case .east: "https://gameinfo-sgp.albiononline.com/api/gameinfo/players/\(id)/kills"
        case .europe: "https://gameinfo-ams.albiononline.com/api/gameinfo/players/\(id)/kills"
        }
    }
    
    func playerLastTenDeathURL(id: String) -> String {
        switch self {
        case .west: "https://gameinfo.albiononline.com/api/gameinfo/players/\(id)/deaths"
        case .east: "https://gameinfo-sgp.albiononline.com/api/gameinfo/players/\(id)/deaths"
        case .europe: "https://gameinfo-ams.albiononline.com/api/gameinfo/players/\(id)/deaths"
        }
    }
}
