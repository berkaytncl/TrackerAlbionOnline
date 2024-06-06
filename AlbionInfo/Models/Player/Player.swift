//
//  Player.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 8.07.2024.
//

import Foundation

struct Player {
    let id: String
    let name: String
    let server: Server
    var tracked: Bool
}

extension Player {
    static let mock: Player = {
        .init(
            id: "qe4SW6aVQLqqnF7OOW_H2Q",
            name: "Matflow",
            server: .europe,
            tracked: true
        )
    }()
}
