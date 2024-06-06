//
//  TrackedPlayersCell.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 12.07.2024.
//

import SwiftUI
import SwiftfulUI

struct TrackedPlayersCell: View {
    var id: String
    var name: String
    var server: Server
    var tracked: Bool
    var onTrashPressed: VoidAction = nil
    
    var body: some View {
        HStack {
            Text(name)
            +
            Text("(\(server.localizedDescription.lowercased()))")
            
            Image(systemName: "trash")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .asButton {
                    onTrashPressed?()
                }
        }
        .padding(6)
        .padding(.horizontal, 4)
        .background(tracked ? .albionBrown : .albionBrown.opacity(0.7))
        .foregroundStyle(.albionDarkBrown)
    }
}

#Preview {
    TrackedPlayersCell(
        id: Player.mock.id,
        name: Player.mock.name,
        server: Player.mock.server,
        tracked: Player.mock.tracked
    )
}
