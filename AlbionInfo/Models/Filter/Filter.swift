//
//  Filter.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 12.07.2024.
//

import Foundation

protocol Filter: CaseIterable, Hashable, RawRepresentable where AllCases: RandomAccessCollection, RawValue == String {
    var localizedDescription: String { get }
}
