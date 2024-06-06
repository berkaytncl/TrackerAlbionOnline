//
//  Text+Extensions.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 17.07.2024.
//

import SwiftUI

extension Text {
    init(_ key: LocalizedKey) {
        self.init(key.localized)
    }
    
    init(_ key: LocalizedKey, with arguments: CVarArg...) {
        self.init(key.localized(with: arguments))
    }
}
