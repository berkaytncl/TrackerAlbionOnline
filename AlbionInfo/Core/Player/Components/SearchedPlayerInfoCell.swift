//
//  SearchedPlayerInfoCell.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.07.2024.
//

import SwiftUI

struct SearchedPlayerInfoCell: View {
    var player: PlayerServerData
    
    var body: some View {
        ZStack {
            Color.albionBrown.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    nameInfoSection
                        .frame(maxWidth: .infinity, alignment: .leading)
                    guildInfoSection
                }
                playerKDFameSection
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .padding(.horizontal, 4)
        }
        .lineLimit(1)
        .fontWeight(.medium)
        .foregroundStyle(.albionDarkBrown)
    }
    
    private var nameInfoSection: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: 21, height: 21)
                .padding(.horizontal, 2)
            
            Text(player.playerData.name)
        }
    }
    private var guildInfoSection: some View {
        HStack {
            HStack(spacing: 4) {
                if let guildName = player.playerData.guildName, !guildName.isEmpty {
                    if let allianceName = player.playerData.allianceName, !allianceName.isEmpty {
                        Text(allianceName.description)
                    }
                    Text(guildName.isEmpty ? "" : "\(guildName)")
                } else {
                    Text("-")
                }
            }
            
            Image(.guild)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
        }
    }
    
    private var playerKDFameSection: some View {
        HStack {
            HStack {
                Image(.sword)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                Text(player.playerData.killFame.abbreviated)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image(systemName: "percent")
                Text(player.playerData.fameRatio.description)
            }
            
            HStack {
                Text(player.playerData.deathFame.abbreviated)
                
                Image(.skull)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    SearchedPlayerInfoCell(player: .init(playerData: .mock, server: .europe))
}
