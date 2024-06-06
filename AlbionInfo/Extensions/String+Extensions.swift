//
//  String+Extensions.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import Foundation

extension String {
    func toDateFormat(language: Language) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = isoFormatter.date(from: self) {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: language.rawValue)
            
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            let dateYear = calendar.component(.year, from: date)
            if dateYear == currentYear {
                formatter.dateFormat = "dd MMMM HH:mm"
            } else {
                formatter.dateFormat = "dd MMMM yyyy HH:mm"
            }
            
            return formatter.string(from: date)
        } else {
            return nil
        }
    }
}
