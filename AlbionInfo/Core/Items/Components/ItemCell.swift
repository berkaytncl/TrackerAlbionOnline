//
//  ItemCell.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 10.06.2024.
//

import SwiftUI

struct ItemCell: View {
    let name: String
    let uniqueName: String
    var isFavorited: Bool = false
    var onFavoritePressed: VoidAction = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .bottomTrailing) {
                EquipmentCell(
                    equipmentData: EquipmentData(
                        count: 1,
                        quality: 0,
                        itemId: uniqueName
                    )
                )
                .frame(width: 60, height: 60)
                
                Group {
                    if isFavorited {
                        Image(systemName: "star.fill")
                            .offset(x: 3, y: 2)
                    } else {
                        Image(systemName: "star")
                            .offset(x: 3, y: 2)
                    }
                }
            }
            .onTapGesture {
                onFavoritePressed?()
            }
            
            Text(name)
                .font(.callout)
                .foregroundStyle(.albionDarkBrown)
                .lineLimit(2)
                .padding(.horizontal, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(4)
        .fontWeight(.medium)
        .foregroundStyle(.albionBrown)
    }
}

#Preview {
    HStack {
        let name: String = LocalizedItem.mock.localizedNames.enUs
        let uniqueName: String = LocalizedItem.mock.uniqueName
        VStack {
            ItemCell(name: name, uniqueName: uniqueName)
            ItemCell(name: name, uniqueName: uniqueName)
        }
        VStack {
            ItemCell(name: name, uniqueName: uniqueName)
            ItemCell(name: name, uniqueName: uniqueName)
        }
    }
}
