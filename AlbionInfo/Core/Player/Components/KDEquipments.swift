//
//  KDEquipments.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 13.07.2024.
//

import SwiftUI
import SwiftfulUI

struct KDEquipments: View {
    let kdReport: KDReportResponse
    
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
                EquipmentCell(equipmentData: equipment?.bag, image: .bagRounded)
                EquipmentCell(equipmentData: equipment?.mainHand, image: .weaponLRounded)
                EquipmentCell(equipmentData: equipment?.food, image: .foodRounded)
            }
            
            VStack(spacing: 0) {
                EquipmentCell(equipmentData: equipment?.head, image: .helmetRounded)
                EquipmentCell(equipmentData: equipment?.armor, image: .armorRounded)
                EquipmentCell(equipmentData: equipment?.shoes, image: .shoesRounded)
                EquipmentCell(equipmentData: equipment?.mount, image: .mountRounded)
            }
            
            VStack(spacing: 0) {
                EquipmentCell(equipmentData: equipment?.cape, image: .capeRounded)
                EquipmentCell(equipmentData: equipment?.offHand, image: .weaponRRounded)
                EquipmentCell(equipmentData: equipment?.potion, image: .potionRounded)
            }
        }
    }
}

#Preview {
    KDEquipments(kdReport: .mock)
}
