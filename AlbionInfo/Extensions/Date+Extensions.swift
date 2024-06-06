//
//  Date+Extensions.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 17.07.2024.
//

import Foundation

extension Date {    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
         return shortFormatter.string(from: self)
     }
}
