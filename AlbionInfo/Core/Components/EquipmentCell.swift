//
//  EquipmentCell.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 13.07.2024.
//

import SwiftUI

struct EquipmentCell: View {
    let equipmentData: EquipmentData?
    var image: ImageResource = .bagRounded
    var imagePressed: Action<String> = nil
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            let itemCount = equipmentData?.count ?? 0
            
            ImageLoaderView(uniqueItemName: equipmentData?.itemId, quality: equipmentData?.quality) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(1, contentMode: .fit)
                    .scaleEffect(0.78)
            }
            .aspectRatio(1, contentMode: .fit)
            
            if itemCount > 1 {
                Text(itemCount.description)
                    .foregroundStyle(.albionWhite)
                    .padding(6)
                    .padding(.horizontal, 2)
            }
        }
        .onTapGesture {
            guard let itemId = equipmentData?.itemId else { return }
            imagePressed?(itemId)
        }
    }
}

#Preview {
    EquipmentCell(equipmentData: KDReportResponse.mock.victim.equipment.mainHand, image: .bagRounded)
}
