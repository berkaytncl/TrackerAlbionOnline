//
//  UserDefaults+Extensions.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 16.06.2024.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let selectedServer = "selected_server"
        static let reportsType = "reports_type_filter"
        static let sortBy = "sort_by_filter"
        static let orderType = "order_type_filter"
    }
    
    var selectedServer: Server {
        get {
            let rawValue = UserDefaults.standard.string(forKey: Keys.selectedServer) ?? Server.europe.rawValue
            return Server(rawValue: rawValue) ?? .europe
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.selectedServer)
        }
    }
    
    var reportsType: ReportsType {
        get {
            let rawValue = UserDefaults.standard.string(forKey: Keys.reportsType) ?? ReportsType.both.rawValue
            return ReportsType(rawValue: rawValue) ?? .both
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.reportsType)
        }
    }
    
    var sortBy: SortBy {
        get {
            let rawValue = UserDefaults.standard.string(forKey: Keys.sortBy) ?? SortBy.time.rawValue
            return SortBy(rawValue: rawValue) ?? .time
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.sortBy)
        }
    }
    
    var orderType: OrderType {
        get {
            let rawValue = UserDefaults.standard.string(forKey: Keys.orderType) ?? OrderType.ascending.rawValue
            return OrderType(rawValue: rawValue) ?? .ascending
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.orderType)
        }
    }
}
