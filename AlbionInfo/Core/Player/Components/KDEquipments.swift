//
//  KDEquipments.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 13.07.2024.
//

import SwiftUI

struct KDEquipments: View {
    let kdReport: KDReportResponse
    var itemPressed: Action<String> = nil
    
    var body: some View {
        HStack {
            equipmentsSection(equipment: kdReport.killer?.equipment)
                
            Rectangle()
                .frame(width: 1, height: 200)
                
            equipmentsSection(equipment: kdReport.victim.equipment)
        }
    }
    
    private func equipmentsSection(equipment: Equipment?) -> some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                EquipmentCell(equipmentData: equipment?.bag, image: .bagRounded, imagePressed: itemPressed)
                EquipmentCell(equipmentData: equipment?.mainHand, image: .weaponLRounded, imagePressed: itemPressed)
                EquipmentCell(equipmentData: equipment?.food, image: .foodRounded, imagePressed: itemPressed)
            }
            
            VStack(spacing: 0) {
                EquipmentCell(equipmentData: equipment?.head, image: .helmetRounded, imagePressed: itemPressed)
                EquipmentCell(equipmentData: equipment?.armor, image: .armorRounded, imagePressed: itemPressed)
                EquipmentCell(equipmentData: equipment?.shoes, image: .shoesRounded, imagePressed: itemPressed)
                EquipmentCell(equipmentData: equipment?.mount, image: .mountRounded, imagePressed: itemPressed)
            }
            
            VStack(spacing: 0) {
                EquipmentCell(equipmentData: equipment?.cape, image: .capeRounded, imagePressed: itemPressed)
                EquipmentCell(equipmentData: equipment?.offHand, image: .weaponRRounded, imagePressed: itemPressed)
                EquipmentCell(equipmentData: equipment?.potion, image: .potionRounded, imagePressed: itemPressed)
            }
        }
    }
}

#Preview {
    KDEquipments(kdReport: .mock)
}
