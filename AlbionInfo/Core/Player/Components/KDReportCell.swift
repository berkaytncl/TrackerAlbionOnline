//
//  KDReportCell.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import SwiftUI

struct KDReportCell: View {
    var kdReport: KDReportResponse
    
    var body: some View {
        VStack(spacing: 2) {
            nameInfoSection
            guildInfoSection
            killFameAndIpSection
            fightInfoSection
            dateSection
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .padding(.horizontal, 4)
        .lineLimit(1)
        .fontWeight(.medium)
        .foregroundStyle(.albionDarkBrown)
        .background(.albionBrown)
    }
    
    private var nameInfoSection: some View {
        HStack {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 21, height: 21)
                    .padding(.horizontal, 2)
                
                Text(kdReport.killer?.name ?? "-")
                
                Image(systemName: "trophy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(.crossedSwords)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 25, height: 25)
            
            HStack {
                Text(kdReport.victim.name)
                    .strikethrough()
                
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 21, height: 21)
                    .padding(.horizontal, 2)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var guildInfoSection: some View {
        HStack {
            HStack {
                Image(.guild)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                if let killer = kdReport.killer, !killer.guildName.isEmpty {
                    Text(killer.allianceTag.isEmpty ? "" : "[\(killer.allianceTag)] ")
                    +
                    Text(killer.guildName.isEmpty ? "" : "\(killer.guildName)")
                } else {
                    Text("-")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                if !kdReport.victim.guildName.isEmpty {
                    Text(kdReport.victim.allianceTag.isEmpty ? "" : "[\(kdReport.victim.allianceTag)] ")
                    +
                    Text("\(kdReport.victim.guildName)")
                } else {
                    Text("-")
                }
                
                Image(.guild)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var killFameAndIpSection: some View {
        HStack {
            HStack {
                Image(systemName: "bolt")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text("\(Int(kdReport.killer?.avgIP.rounded() ?? 0)) IP")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "medal.star")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            
            Text(kdReport.killFame.abbreviated)
            
            HStack {
                Text("\(Int(kdReport.victim.avgIP.rounded())) IP")
                
                Image(systemName: "bolt")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var fightInfoSection: some View {
        HStack {
            HStack {
                Image(.crossedSwords)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text("\(kdReport.numberOfParticipants) VS 1")
            }
            .frame(maxWidth: .infinity)
                
            HStack {
                Image(systemName: "bag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(5)
                
                Text(kdReport.victim.loot.compactMap { $0 }.count.description)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private var dateSection: some View {
        HStack {
            Image(systemName: "clock")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(5)
            
            if let locatedTimeStamp = kdReport.timeStamp.toDateFormat(
                language: LanguageManager.shared.selectedLanguage
            ) {
                Text(locatedTimeStamp)
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    KDReportCell(kdReport: .mock)
}
